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
	@echo " clean   Remove unused plugins"
	@echo " destroy Remove ~/.vimrc and ~/.vim"
	@echo " install Install vimrc and vim-plug"
	@echo " update  Upgrade plugins"
	@echo " upgrade Upgrade vim-plug"
	@echo

.PHONY: clean
clean:
	@vim +PlugClean! +qall

.PHONY: destroy
destroy:
	rm -f "$(dotvimrc)"
	rm -rf "$(dotvim)"

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
	@cp -p "$(<)" "$(@)"
	@chmod 644 "$(@)"

$(dotvim)/autoload/plug.vim: $(dotvim)/autoload $(dotvim)/plugged
	@curl -fLo "$(@)" "https://$(github)/junegunn/vim-plug/master/plug.vim"
	@chmod 644 "$(@)"

$(dotvim)/autoload: $(dotvim)
	@mkdir -m 755 -p "$(@)"

$(dotvim)/plugged: $(dotvim)
	@mkdir -m 755 -p "$(@)"

$(dotvim): $(HOME)
	@mkdir -m 755 -p "$(@)"

