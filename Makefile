github   := raw.githubusercontent.com
dotvim   := $(HOME)/.vim
dotvimrc := $(HOME)/.vimrc
vimfiles := vimfiles.tar.gz

.PHONY: help
help:
	@echo
	@echo "Usage:"
	@echo " make [target]"
	@echo
	@echo "Targets:"
	@echo " archive Create $(vimfiles) (requires install)"
	@echo " clean   Remove unused plugins"
	@echo " destroy Remove ~/.vimrc and ~/.vim"
	@echo " install Install vimrc and vim-plug"
	@echo " update  Upgrade plugins"
	@echo " upgrade Upgrade vim-plug"
	@echo

.PHONY: archive
archive: $(vimfiles)

.PHONY: clean
clean:
	@rm -f "$(vimfiles)"
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

$(vimfiles): $(dotvim) $(dotvimrc) install.cmd
	@$(eval $@_TMP := $(shell mktemp -d))
	@mkdir "$($@_TMP)/vim"
	@cp    "install.cmd" "$($@_TMP)/vim/install.cmd"
	@cp    "$(dotvimrc)" "$($@_TMP)/vim/vimrc"
	@cp -r "$(dotvim)"   "$($@_TMP)/vim/vim"
	@tar --create --directory "$($@_TMP)" --file="$(@)" --gzip vim
	@rm -rf "$($@_TMP)"

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

