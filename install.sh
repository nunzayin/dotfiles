#!/bin/bash

# Workspace installation script
# You better invoke this script via make install

if [[ -n $$(command -v yay) ]]; then
    sudo pacman -S --needed base-devel
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si
fi
