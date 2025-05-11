CL_B_CYAN="%{$fg_bold[cyan]%}"
CL_B_WHITE="%{$fg_bold[white]%}"
CL_B_RED="%{$fg_bold[red]%}"
CL_CLR="%{$reset_color%}"

PROMPT="$CL_B_CYAN┌[$CL_B_WHITE%c$CL_B_CYAN]"
PROMPT+='$(git_prompt_info)'
PROMPT+="
└>$CL_CLR "

ZSH_THEME_GIT_PROMPT_PREFIX="-[${CL_B_WHITE}git::"
ZSH_THEME_GIT_PROMPT_SUFFIX="$CL_B_CYAN]"
ZSH_THEME_GIT_PROMPT_DIRTY="$CL_B_RED!$CL_CLR"
ZSH_THEME_GIT_PROMPT_CLEAN=""
