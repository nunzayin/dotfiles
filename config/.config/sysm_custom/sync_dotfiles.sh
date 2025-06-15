# sync dotfiles module

MODULE="sync_dotfiles"
DEPS=("$HOME/dotfiles/sync.sh")

if check_deps; then
    stage "SYNCING CONFIG FILES"
    $HOME/dotfiles/sync.sh
fi
