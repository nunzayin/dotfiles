help:
	@echo 'Usage:'
	@echo '	help - display this help message (default)'
	@echo '	all - install workspace and then synchronize configs'
	@echo '	install - install the whole workspace'
	@echo '	sync - synchronize configs'

all: install sync

install:
	./install.sh

sync:
	./sync.sh
