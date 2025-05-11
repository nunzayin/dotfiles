#!/bin/bash

# Workspace installation script
# You better invoke this script via make install

echo "Performing workspace installation..."

if ! [[ -n $(command -v yay) ]]; then
    echo "yay not found, installing..."
    sudo pacman -S --needed base-devel
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si
    cd ..
fi
