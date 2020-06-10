bundle := bundle.tgz

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
init:
	@git submodule update --init --recursive

.PHONY: size
size:
	@du -hs pack/submodules/start/* | sort -hr

.PHONY: update-helptags
update-helptags:
	@vim -c "helptags ALL" -c q

.PHONY: update-submodules
update-submodules:
	@git submodule update --remote

.PHONY: update
update: update-submodules update-helptags

$(bundle): Makefile README.md vimrc .gitignore .gitmodules
	@tar cvfz $(@) $(^) after autoload bin pack

