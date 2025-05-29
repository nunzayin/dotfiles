#!/bin/bash

# Workspace installation script

WORKDIR="$(dirname "$(realpath "$0")")"
PWD=$(pwd)

function yay_semi_auto() {
    LANG=C yay --answerdiff None --answerclean None --mflags "--noconfirm" "$@"
}
function yay_auto() {
    echo "y" | yay_semi_auto "$@"
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

echo "Workspace installation procedure complete."

cd $PWD
