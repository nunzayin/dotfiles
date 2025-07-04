#!/bin/bash

# Dotfiles synchronization script

CURRENT_DIR="$(pwd)"
WORKDIR="$(dirname "$(realpath "$0")")"

stow -Rv --adopt --dir $WORKDIR/config --target $HOME .
cd $WORKDIR
git restore .
cd $CURRENT_DIR
