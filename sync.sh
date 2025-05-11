#!/bin/bash

# Dotfiles synchronization script
# You better invoke this script via make sync

for f in $(ls -1A ./config); do
    cp -rv "./config/$f" "$HOME"
done
