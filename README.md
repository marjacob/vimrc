vimrc
=====

Installation
------------

### Linux

```
git clone https://github.com/marjacob/vimrc.git ~/.vim
cd ~/.vim
make init
```

### Windows

[GNU Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm)

```
cd %userprofile%
git clone https://github.com/marjacob/vimrc.git vimfiles
cd vimfiles
make init
```

Setup for Python
----------------

```console
apt install python3 python3-pip
pip3 install python-language-server reorder-python-imports yapf
```

Refer to [python.vim](after/ftplugin/python.vim) for more context.

Plugins
-------

Move to the Vim home directory with `cd %userprofile%\vimfiles` on Windows,
or `cd ~/.vim` on other operating systems.

### Add

```
cd pack/submodules/start
git submodule add https://github.com/tpope/vim-sensible.git
```

### Update

#### Remove a plugin

```
git rm pack/submodules/start/vim-sensible
```

#### Update all plugins

The `update` target updates all initialized submodules and generates
helptags.

```
make update
```

#### Update one plugin

```
cd pack/submodules/start/vim-sensible
git pull origin master
```
