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
    rm -vrf ./yay
fi

if ! [[ -e "$HOME/togglesound" ]]; then
    git clone https://github.com/nunzayin/togglesound
fi

yay_semi_auto -S --needed $(cat $WORKDIR/deps.txt)

CONFIG_HOME="$HOME/.config"
mkdir -p $CONFIG_HOME/clipcat
clipcatd default-config > $CONFIG_HOME/clipcat/clipcatd.toml
clipcatctl default-config > $CONFIG_HOME/clipcat/clipcatctl.toml
clipcat-menu default-config > $CONFIG_HOME/clipcat/clipcat-menu.toml
sed -i -e 's/finder = "rofi"/finder = "dmenu"/' $CONFIG_HOME/clipcat/clipcat-menu.toml

systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service
echo "Audio will work properly only after reboot"

echo "Workspace installation procedure complete."

cd $PWD
