#!/bin/bash

# Workspace installation script

WORKDIR=$(dirname "$0")
PWD=$(pwd)

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
    yay -Syu
    yay -S --needed trash-cli
    trash ./yay
fi

if ! [[ -e $HOME/util ]]; then
    cd $HOME
    git clone https://github.com/nunzayin/util
fi

yay -S --needed zsh
if ! [[ -e $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

cat $WORKDIR/deps.txt | yay -S --needed -

echo "Workspace installation procedure complete."

cd $PWD
