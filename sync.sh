#!/bin/bash

# Dotfiles synchronization script

WORKDIR=$(dirname "$0")

for f in $(ls -1A "$WORKDIR/config"); do
    cp -rv "$WORKDIR/config/$f" "$HOME"
done
