export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nz"
zstyle ':omz:update' mode auto

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source <(fzf --zsh)

alias ls='ls -lAh --color=auto'
alias q="exit 0"
alias sm="$HOME/utils/sysmaint/sysmaint.sh"
alias yay='yay --answerdiff None --answerclean None --mflags "--noconfirm"'
alias tree="tree -aR -I '*\.git*'"
alias ci='cd; cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cc='cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cs='cd; cd "$(fd -IHt d | fzf)"'
alias cr='cd /; cd "$(fd -IHt d | fzf)"'
alias zb="zig build --summary all"
alias trash="trash -v"
alias rm="rm -v"
alias tdu='du -sh $HOME/.local/share/Trash'
alias fk='setxkbmap -model pc105 -layout us,ru -variant qwerty -option grp:lalt_lshift_toggle'
alias cal='cal -3mc 1'

export VISUAL='nvim'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H'
export PATH="$HOME/.local/bin:$PATH"

if ! (( $chpwd_functions[(I)autols] )); then
  chpwd_functions+=(autols)
fi
function autols() {
  if [[ -o interactive ]]; then
    emulate -L zsh
    if ! [[ ("$PWD" = "$HOME") || ("$PWD" = "/") ]]; then
        eval "ls -lAh --color=auto"
    fi
  fi
}
