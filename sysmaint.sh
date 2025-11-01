#!/usr/bin/env bash

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_RESET='\033[0m'
EXECUTION_MODE="normal"
ARGS_TASKS=()
TASK_ORDER=(
    "git_pull"
    "mirrors"
    "update"
    "sync_dotfiles"
    "orphans"
    "pacman_cache"
    "syslogs"
)
SM_LOG_FILE="$HOME/.sysm_log"
GIT_PULL_REPOS=(
    "$HOME/togglesound"
    "$HOME/dotfiles"
)
LOADING_ANIMATION=( '|' '/' '-' "\\" )
declare ANIMATION_PID

function task_git_pull() {
    pushd "$(pwd)" > /dev/null
    local GIT_OUTPUT_TMPFILE
    local GIT_EXIT_CODE
    local EXIT_CODE
    ((EXIT_CODE=0))
    for REPO in "${GIT_PULL_REPOS[@]}"; do
        if ! cd $REPO; then
            ((EXIT_CODE+=1))
            continue
        fi
        echo -n "$REPO: "
        GIT_OUTPUT_TMPFILE="$(mktemp)"
        git pull > "$GIT_OUTPUT_TMPFILE"
        ((GIT_EXIT_CODE=$?))
        cat "$GIT_OUTPUT_TMPFILE"
        [[ -n $(grep 'Already up to date' "$GIT_OUTPUT_TMPFILE") ]] \
            || ((EXIT_CODE+=$GIT_EXIT_CODE))
        rm "$GIT_OUTPUT_TMPFILE"
    done
    popd > /dev/null
    return $EXIT_CODE
}

function task_mirrors() {
    rankmirrors /etc/pacman.d/mirrorlist \
        | sudo tee /etc/pacman.d/mirrorlist.new
    if [[ -n $(grep '^Server = .*$' /etc/pacman.d/mirrorlist.new) ]]; then
        sudo rename mirrorlist.new mirrorlist /etc/pacman.d/mirrorlist.new
        return 0
    fi
    echo "Errors were encountered when generating mirrorlist"
    return 1
}

function task_update() {
    yes "" | yay \
        --answerdiff None \
        --answerclean None \
        --mflags "--noconfirm" \
        -Syu
    return $?
}

function task_sync_dotfiles() {
    $HOME/dotfiles/sync.sh
    return $?
}

function task_orphans() {
    orphaned=$(yay -Qqdt | tr "\n" " ")
    if [ -n "$orphaned" ]; then
        yes "" | yay -Rns $orphaned
        return $?
    fi
    echo "No orphaned packages to remove."
    return 0
}

function task_pacman_cache() {
    paccache -vrk2 && paccache -ruk0 || return $?
    return $?
}

function task_syslogs() {
    sudo journalctl --vacuum-time=7d
}

function parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            "-w")
                EXECUTION_MODE="whitelist"
                ;;
            "-b")
                EXECUTION_MODE="blacklist"
                ;;
            "-q")
                EXECUTION_MODE="query"
                ;;
            *)
                ARGS_TASKS+=("$1")
        esac
        shift
    done
}

function sm_log() {
    echo $@ >> $SM_LOG_FILE 2>&1
}

function start_loading_animation() {
    animate_loading &
    ANIMATION_PID="${!}"
}

function animate_loading() {
    while true; do
        for FRAME in "${LOADING_ANIMATION[@]}" ; do
            printf '\b%s' "${FRAME}"
            sleep 0.25
        done
    done
}

function stop_loading_animation() {
    kill "${ANIMATION_PID}" > /dev/null 2>&1
}
trap stop_loading_animation SIGINT

function exec_task() {
    local EXIT_CODE
    local EXIT_CODE_FMT
    sm_log "[SYSM] Performing task \"$1\""
    printf '    %-15s  ' "$1"
    start_loading_animation
    "task_$1" >> $SM_LOG_FILE 2>&1
    ((EXIT_CODE=$?))
    stop_loading_animation
    echo -ne "\r\033[K" # clears line
    if [[ "$EXIT_CODE" -eq 0 ]]; then
        EXIT_CODE_FMT="${COLOR_GREEN}0${COLOR_RESET}"
    else
        EXIT_CODE_FMT="${COLOR_RED}${EXIT_CODE}${COLOR_RESET}"
    fi
    printf '    %-15s ' "$1"
    echo -e "$EXIT_CODE_FMT"
    return $EXIT_CODE
}

function init_log() {
    echo "[SYSM] Initialized sysmaint log at $(date)" > $SM_LOG_FILE 2>&1
    sm_log "[SYSM] Current mode is $EXECUTION_MODE"
}

function end_log() {
    sm_log "[SYSM] Sysmaint iteration complete at $(date)"
}

function normal_mode() {
    local EXIT_CODE
    ((EXIT_CODE=0))
    init_log
    for TASK in "${TASK_ORDER[@]}"; do
        exec_task "$TASK"
        ((EXIT_CODE+=$?))
    done
    end_log
    return $EXIT_CODE
}

function whitelist_mode() {
    local EXIT_CODE
    init_log
    for TASK in "${TASK_ORDER[@]}"; do
        if [[ "${ARGS_TASKS[*]}" =~ "${TASK}" ]]; then
            exec_task "$TASK"
            ((EXIT_CODE+=$?))
        fi
    done
    end_log
    return $EXIT_CODE
}

function blacklist_mode() {
    local EXIT_CODE
    init_log
    for TASK in "${TASK_ORDER[@]}"; do
        if [[ ! "${ARGS_TASKS[*]}" =~ "${TASK}" ]]; then
            exec_task "$TASK"
            ((EXIT_CODE+=$?))
        fi
    done
    end_log
    return $EXIT_CODE
}

function query_mode() {
    printf '%s\n' "${TASK_ORDER[@]}"
    return 0
}

function main() {
    local EXIT_CODE
    tput civis
    parse_args $@
    "${EXECUTION_MODE:?Invalid execution mode}_mode"
    ((EXIT_CODE=$?))
    tput cnorm
    exit $EXIT_CODE
}

main $@
