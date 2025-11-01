[[ $- != *i* ]] && return

if [[ -f "$(command -v fzf)" ]]; then
    eval "$(fzf --bash)"
    COMPLETION_SCRIPT=/usr/share/fzf-tab-completion/bash/fzf-bash-completion.sh
    if [[ -f "$COMPLETION_SCRIPT" ]]; then
        source $COMPLETION_SCRIPT
        bind -x '"\t": fzf_bash_completion'
    fi
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

PS1='┌[\w]\n└> '

alias ls='ls -lAh --color=always'
alias q="exit 0"
alias sm="$HOME/dotfiles/sysmaint.sh"
alias ci='cd; cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cu='cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cs='cd; cd "$(fd -IHt d | fzf)"'
alias cr='cd /; cd "$(fd -IHt d | fzf)"'
alias rm="rm -v"
alias cal='cal -3mc 1'

export VISUAL='nvim'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H'
export PATH="$HOME/.local/bin:$PATH"
