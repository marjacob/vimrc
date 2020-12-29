BUNDLE ?= bundle
bundle := $(BUNDLE).tgz
files  := \
	.git \
	.github \
	.gitignore \
	.gitmodules \
	Makefile \
	README.md \
	after \
	autoload \
	pack \
	tar.cmd \
	vimrc

define unlink
$(if $(filter $(OS),Windows_NT),\
	del /f /q "$(1)" > NUL 2>&1 || exit 0,\
	$(RM) "$(1)")
endef

.PHONY: all
all: bundle

.PHONY: bundle
bundle: $(bundle)

.PHONY: clean
clean:
	@$(call unlink,$(bundle))

.PHONY: init
init: init-submodules update-helptags

.PHONY: init-submodules
init-submodules:
	@git submodule update --init --recursive

.PHONY: reset-master
reset-master:
	@git fetch --all
	@git reset --hard origin/master

.PHONY: size
size:
	@du -hs $(shell find pack/ -maxdepth 3 -mindepth 3 -type d) | sort -h

.PHONY: update
update: update-repository update-submodules update-helptags
	@git status

.PHONY: update-force
update-force: reset-master update

.PHONY: update-helptags
update-helptags:
	@vim --not-a-term -c "helptags ALL" -c q

.PHONY: update-repository
update-repository:
	@git pull --autostash --rebase

.PHONY: update-submodules
update-submodules:
	@git submodule update --init --jobs 4 --remote

$(bundle): $(files)
	@tar cfvz $(@) $(^)
