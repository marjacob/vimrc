bundle := bundle.tgz

.PHONY: all
all: bundle

.PHONY: bundle
bundle: $(bundle)

.PHONY: clean
clean:
	@$(RM) $(bundle)

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
	@tar cvfz $(@) $(^) autoload bin ftdetect pack

