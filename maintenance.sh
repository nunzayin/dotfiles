#!/usr/bin/env bash

GIT_PULL_REPOS=(
    "$HOME/utils/togglesound"
    "$HOME/dotfiles"
)

function git_pull_module() {
    pushd "$(pwd)"
    local EXIT_CODE
    ((EXIT_CODE=1))
    for REPO in "${GIT_PULL_REPOS[@]}"; do
        cd $REPO
        git pull
        ((EXIT_CODE+=$?))
    done
    popd
    return EXIT_CODE
}

function mirrors_module() {
    rankmirrors /etc/pacman.d/mirrorlist \
        | sudo tee /etc/pacman.d/mirrorlist.new
    if [[ -n $(grep '^Server = .*$' /etc/pacman.d/mirrorlist.new) ]]; then
        sudo rename mirrorlist.new mirrorlist /etc/pacman.d/mirrorlist.new
        return 0
    fi
    echo "Errors were encountered when generating mirrorlist"
    return 1
}

function update_module() {
    yes "" | yay \
        --answerdiff None \
        --answerclean None \
        --mflags "--noconfirm" \
        -Syu
    return $?
}

function sync_dotfiles_module() {
    $HOME/dotfiles/sync.sh
    return $?
}

function orphans_module() {
    orphaned=$(yay -Qqdt | tr "\n" " ")
    if [ -n "$orphaned" ]; then
        yes "" | yay -Rns $orphaned
        return $?
    fi
    echo "No orphaned packages to remove."
    return 0
}
