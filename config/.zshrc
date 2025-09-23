export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source <(fzf --zsh)

CL_B_CYAN="%{$fg_bold[cyan]%}"
CL_B_WHITE="%{$fg_bold[white]%}"
CL_B_RED="%{$fg_bold[red]%}"
CL_CLR="%{$reset_color%}"
PROMPT="$CL_B_CYAN┌[$CL_B_WHITE%d$CL_B_CYAN]"
PROMPT+='$(git_prompt_info)'
PROMPT+="
└>$CL_CLR "
ZSH_THEME_GIT_PROMPT_PREFIX="-[${CL_B_WHITE}git::"
ZSH_THEME_GIT_PROMPT_SUFFIX="$CL_B_CYAN]"
ZSH_THEME_GIT_PROMPT_DIRTY="$CL_B_RED!$CL_CLR"
ZSH_THEME_GIT_PROMPT_CLEAN=""

alias ls='ls -lAh --color=always'
alias q="exit 0"
alias sm="$HOME/utils/sysmaint/sysmaint.sh"
alias yay='yay --answerdiff None --answerclean None --mflags "--noconfirm" --color always'
alias tree="tree -aR -I '*\.git*'"
alias ci='cd; cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cc='cd "$(fd --no-ignore-vcs -Ht d | fzf)"'
alias cs='cd; cd "$(fd -IHt d | fzf)"'
alias cr='cd /; cd "$(fd -IHt d | fzf)"'
alias trash="trash -v"
alias rm="rm -v"
alias cal='cal -3mc 1'

export VISUAL='nvim'
export FZF_DEFAULT_COMMAND='fd --no-ignore-vcs -H'
export PATH="$HOME/.local/bin:$PATH"
