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

.PHONY: update
update:
	@git submodule foreach git pull origin master

$(bundle): Makefile README.md make.cmd vimrc .gitignore .gitmodules
	@tar cvfz $(@) $(^) bin pack

