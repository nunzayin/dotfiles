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
alias ci='cd; cd $(fd --no-ignore-vcs -Ht d | fzf)'
alias zb="zig build --summary all"

export VISUAL='nvim'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H'
