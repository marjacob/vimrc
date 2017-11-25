SHELL := /bin/bash

github   := raw.githubusercontent.com
dotvim   := $(HOME)/.vim
dotvimrc := $(HOME)/.vimrc

.PHONY: help
help:
	@echo
	@echo "Usage:"
	@echo " make [target]"
	@echo
	@echo "Targets:"
	@echo " clean   Remove unused directories"
	@echo " install Install vimrc and vim-plug"
	@echo " update  Upgrade plugins"
	@echo " upgrade Upgrade vim-plug"
	@echo

.PHONY: clean
clean:
	@vim +PlugClean! +qall

.PHONY: install
install: $(dotvimrc) $(dotvim)/autoload/plug.vim
	@vim +PlugInstall +qall

.PHONY: update
update:
	@vim +PlugUpdate +qall

.PHONY: upgrade
upgrade:
	@vim +PlugUpgrade +qall

$(dotvimrc): vimrc
	@install -B "$(USER)" -b -c -m 655 -p -S "$(<)" "$(@)"

$(dotvim)/autoload/plug.vim: $(dotvim)/autoload $(dotvim)/plugged
	@curl -fLo "$(@)" "https://$(github)/junegunn/vim-plug/master/plug.vim"

$(dotvim)/autoload: $(dotvim)
	@mkdir -m 755 -p "$(@)"

$(dotvim)/plugged: $(dotvim)
	@mkdir -m 755 -p "$(@)"

$(dotvim): $(HOME)
	@mkdir -m 755 -p "$(@)"

