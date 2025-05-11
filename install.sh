#!/bin/bash

# Workspace installation script
# You better invoke this script via make install

echo "Performing workspace installation..."

if ! [[ -n $(command -v yay) ]]; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    yay -Syu
    yay -S --needed trash-cli
    trash ./yay
fi

if ! [[ -e ~/util ]]; then
    cd ~
    git clone https://github.com/nunzayin/util
fi

