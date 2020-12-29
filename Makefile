BUNDLE ?= bundle
bundle := $(BUNDLE).tgz
files  := \
	.git \
	.gitignore \
	.gitmodules \
	Makefile \
	README.md \
	after \
	autoload \
	pack \
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
	@git submodule update --init --recursive

.PHONY: reset-master
reset-master:
	@git fetch --all
	@git reset --hard origin/master

.PHONY: setup-pip
setup-pip:
	pip3 install --upgrade --user  \
		python-language-server \
		reorder-python-imports \
		yapf

.PHONY: setup-python
setup-python:
	apt update
	apt install -y python3 python3-pip

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
	@git submodule update --init --jobs 8 --remote

$(bundle): $(files)
	@tar cfvz $(@) $(^)
