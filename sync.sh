#!/bin/bash

# Dotfiles synchronization script

pushd "$(pwd)"
WORKDIR="$(dirname "$(realpath "$0")")"
stow -Rv --adopt --dir $WORKDIR/config --target $HOME .
cd $WORKDIR
git restore .
popd
