SHELL=/bin/bash

help:
	@echo 'Usage:'
	@echo '	help - display this help message (default)'
	@echo '	all - install workspace and then synchronize configs'
	@echo '	install - install the whole workspace'
	@echo '	sync - synchronize configs'

all: install sync

install:
	if [[ -n $$(command -v yay) ]]; then
		sudo pacman -S --needed base-devel
		git clone "https://aur.archlinux.org/yay.git"
		cd yay
		makepkg -si
	fi
