export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nz"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source <(fzf --zsh)

alias ls='ls -lAh --color=auto'
alias q="exit 0"
alias cs="$HOME/dotfiles/sync.sh"
alias sm="$HOME/util/sysmaint.sh"

export VISUAL='nvim'
