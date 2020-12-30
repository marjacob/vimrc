" vimrc

if has('vim_starting')
  set nocompatible
else
  finish
endif

" ..... leader ...............................................................

let mapleader = ","
let maplocalleader = ";"

nnoremap \ ,

" ..... startup ..............................................................

" encoding
set encoding=utf-8
set fileencoding=utf-8

" indentation
set noexpandtab
set shiftwidth=8
set softtabstop=8
set tabstop=8
set textwidth=78

" numbers
set number
set numberwidth=5
set relativenumber

set clipboard+=unnamed
set fileformat=unix
set fileformats=unix,dos
set fillchars+=vert:\ "
set formatoptions+=ro
set hidden
set ignorecase
set infercase
set magic
set mouse=a
set noshowmode
set noswapfile
set nowrap
set report=0
set scrolloff=5
set shortmess+=I
set splitbelow
set splitright
set ttyfast
set wildmode=list:longest,full

" no timeout for mapped keys
set notimeout
set ttimeout

if has('cindent')
  set cindent
endif

if has('extra_search')
  set incsearch
endif

if has('folding')
  set foldclose=all
  set foldlevel=0
  set nofoldenable
endif

if has('syntax')
  set colorcolumn=+1
endif

if has('virtualedit')
  set virtualedit=block
endif

" ..... autocommands .........................................................

function! s:command_enter()
  if has('extra_search')
    set hlsearch
  endif
endfunction

function! s:command_leave()
  if has('extra_search')
    set nohlsearch
  endif
endfunction

augroup vimrc
  autocmd!
  if exists('##CmdlineEnter')
    autocmd CmdlineEnter /,\? :call s:command_enter()
  endif
  if exists('##CmdlineLeave')
    autocmd CmdlineLeave /,\? :call s:command_leave()
  endif
augroup end
