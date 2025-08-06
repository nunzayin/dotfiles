#!/bin/bash

# Needed packages ensuring script

WORKDIR="$(dirname "$(realpath "$0")")"

yay --answerdiff None --answerclean None --mflags "--noconfirm" -S --needed $(cat $WORKDIR/deps.txt)
