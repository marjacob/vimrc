vimrc
=====

Installation
------------

### Linux

```
git clone https://github.com/marjacob/vimrc.git ~/.vim
cd ~/.vim
git submodule update --init --recursive
```

### Windows

```
cd %userprofile%
git clone https://github.com/marjacob/vimrc.git vimfiles
cd vimfiles
git submodule update --init --recursive
```

Plugins
-------

Move to the Vim home directory with `cd %userprofile%\vimfiles` on Windows, or `cd ~/.vim` on other operating systems.

### Add

```
cd pack/submodules/start
git submodule add https://github.com/tpope/vim-sensible.git
```

### Update

#### Remove a plugin

```
git submodule deinit pack/submodules/start/vim-sensible
git rm -r pack/submodules/start/vim-sensible
rm -r .git/modules/pack/submodules/start/vim-sensible
```

#### Update all plugins

```
git submodule foreach git pull origin master
```

#### Update one plugin

```
cd pack/submodules/start/vim-sensible
git pull origin master
```

