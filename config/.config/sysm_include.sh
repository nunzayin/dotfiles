REPOS=(
    "$HOME/utils/sysmaint"
    "$HOME/utils/togglesound"
    "$HOME/dotfiles"
)
. $MODULES/git_pull.sh

. $MODULES/mirrors.sh
. $MODULES/update.sh

. $HOME/.config/sysm_custom/sync_dotfiles.sh
. $MODULES/orphans.sh
. $MODULES/pacman_cache.sh
. $MODULES/syslogs.sh
