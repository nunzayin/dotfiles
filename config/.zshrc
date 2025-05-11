export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nz"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

alias ls='ls -lAh --color=auto'
alias q="exit 0"

export VISUAL='nvim'
