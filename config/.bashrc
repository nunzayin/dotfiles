[[ $- != *i* ]] && return

eval "$(fzf --bash)"

PS1='┌[\w]\n└> '

alias ls='ls -lAh --color=always'
alias q="exit 0"
alias sm="$HOME/utils/sysmaint/sysmaint.sh"
alias ci='cd; cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cu='cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cs='cd; cd "$(fd -IHt d | fzf)"'
alias cr='cd /; cd "$(fd -IHt d | fzf)"'
alias rm="rm -v"
alias cal='cal -3mc 1'

export VISUAL='nvim'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H'
export PATH="$HOME/.local/bin:$PATH"
