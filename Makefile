SHELL := /bin/bash

vim   := $(HOME)/.vim
vimrc := $(HOME)/.vimrc

all: install

.PHONY: install
install: $(vimrc) $(vim)/autoload/plug.vim
	vim +PlugInstall +qall

.PHONY: update
update:
	vim +PlugUpdate +qall

.PHONY: upgrade
upgrade:
	vim +PlugUpgrade +qall

$(vimrc): vimrc
	install -B "$(USER)" -b -c -m 655 -S "$(<)" "$(@)"

$(vim)/autoload/plug.vim: $(vim)/autoload $(vim)/plugins
	curl -fLo "$(@)" \
		"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

$(vim)/autoload: $(vim)
	mkdir -p "$(@)"

$(vim)/plugins: $(vim)
	mkdir -p "$(@)"

$(vim): $(HOME)
	mkdir -p "$(@)"

#uninstall:

