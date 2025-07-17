#!/bin/bash

# Workspace installation script

WORKDIR="$(dirname "$(realpath "$0")")"
PWD=$(pwd)

function yay_semi_auto() {
    yay --answerdiff None --answerclean None --mflags "--noconfirm" "$@"
}
function yay_auto() {
    echo "y" | LANG=C yay_semi_auto "$@"
}

echo "Performing workspace installation..."

if ! [[ -n $(command -v yay) ]]; then
    sudo pacman -S --needed base-devel
    cd $WORKDIR
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    if ! [[ -n $(command -v yay) ]]; then
        echo "Could not satisfy vital dependency: yay"
        cd $PWD
        exit 1
    fi
    cd ..
    yay_auto -Syu
    yay_auto -S --needed trash-cli
    trash ./yay
fi

mkdir $HOME/utils
cd $HOME/utils
if ! [[ -e "$HOME/utils/sysmaint" ]]; then
    git clone https://github.com/nunzayin/sysmaint
fi
if ! [[ -e "$HOME/utils/togglesound" ]]; then
    git clone https://github.com/nunzayin/togglesound
fi

yay_auto -S --needed zsh
if ! [[ -n $(zsh -ic "command -v omz") ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

yay_semi_auto -S --needed $(cat $WORKDIR/deps.txt)

mkdir -p $XDG_CONFIG_HOME/clipcat
clipcatd default-config > $XDG_CONFIG_HOME/clipcat/clipcatd.toml
clipcatctl default-config > $XDG_CONFIG_HOME/clipcat/clipcatctl.toml
clipcat-menu default-config > $XDG_CONFIG_HOME/clipcat/clipcat-menu.toml

systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service
echo "Audio will work properly only after reboot"

echo "Workspace installation procedure complete."

cd $PWD
