# vimrc

## Installation

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

## Plugins

```
cd ~/.vim
```

### Add

```
git submodule add https://github.com/tpope/vim-sensible.git bundle/vim-sensible
```

### Update

#### Remove a plugin

```
git submodule deinit bundle/vim-sensible
git rm -r bundle/vim-sensible
rm -r .git/modules/bundle/vim-sensible
```

#### Update all plugins

```
git submodule foreach git pull origin master
```

#### Update one plugin

```
cd bundle/vim-sensible
git pull origin master
```

