. $MODULES/mirrors.sh
. $MODULES/update.sh

REPOS=(
    "$HOME/dotfiles"
    "$HOME/util"
)
. $MODULES/git_fetch.sh

. $MODULES/orphans.sh
. $MODULES/pacman_cache.sh
. $MODULES/syslogs.sh
. $MODULES/trash_info.sh
