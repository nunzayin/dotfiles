. $MODULES/mirrors.sh
. $MODULES/update.sh

REPOS=(
    "$HOME/utils/sysmaint"
    "$HOME/utils/togglesound"
)
. $MODULES/git_pull.sh

stage "SYNCING CONFIG FILES"
$HOME/dotfiles/sync.sh

. $MODULES/orphans.sh
. $MODULES/pacman_cache.sh
. $MODULES/syslogs.sh
. $MODULES/trash_info.sh
