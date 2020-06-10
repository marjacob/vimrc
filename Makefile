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

.PHONY: update
update:
	@git submodule foreach git pull origin master

$(bundle): Makefile README.md make.cmd vimrc .gitignore .gitmodules
	@tar cvfz $(@) $(^) after autoload bin pack

