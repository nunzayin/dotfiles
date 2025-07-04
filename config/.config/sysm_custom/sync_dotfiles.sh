# sync dotfiles module

MODULE="sync_dotfiles"
DEPS=("$HOME/dotfiles/sync.sh")

if module_prolog; then
    $HOME/dotfiles/sync.sh
fi
