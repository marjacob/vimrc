bundle := bundle.tgz
files  := \
	.git        \
	.gitignore  \
	.gitmodules \
	Makefile    \
	README.md   \
	after       \
	autoload    \
	pack        \
	vimrc

.PHONY: all
all: bundle

.PHONY: bundle
bundle: $(bundle)

.PHONY: clean
clean:
ifeq ($(OS),Windows_NT)
	@del /f /q $(bundle) > NUL 2>&1 || exit 0
else
	@$(RM) $(bundle)
endif

.PHONY: init
init: init-submodules update-helptags

.PHONY: init-submodules
init-submodules:
	@git submodule init

.PHONY: size
size:
	@du -hs $(shell find pack/ -maxdepth 3 -mindepth 3 -type d) | sort -h

.PHONY: update
update: update-repository update-helptags
	@git status

.PHONY: update-helptags
update-helptags:
	@vim --not-a-term -c "helptags ALL" -c q

.PHONY: update-repository
update-repository:
	@git pull --rebase --recurse

$(bundle): $(files)
	@tar cfvz $(@) $(^)
