" ~/.vimrc

if has('vim_starting')
  runtime! bundle/vim-pathogen/autoload/pathogen.vim
  silent! execute pathogen#infect("bundle/{}")
  silent! execute pathogen#infect("vendor/{}")
endif

if has('win32') || has ('win64')
  let $VIMHOME = $VIM."/vimfiles"
else
  let $VIMHOME = $HOME."/.vim"
endif

set nocompatible
let mapleader = ","
nnoremap \ ,

""""" Encoding """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf8
  setlocal fileencoding=utf-8
  setlocal fileencodings=utf-8,latin1,default
endif

""""" Plugins """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline/vim-airline
if has('gui_running')
  let g:airline_solarized_bg='dark'
  let g:airline_theme='solarized'
endif

let g:airline#extensions#tabline#enabled = 1

" Raimondi/delimitMate
" Remove <> (<:>).
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = ""

""""" Appearance """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
set number
set numberwidth=5

if has('extra_search')
  set hlsearch
endif

if has('syntax')
  set colorcolumn=+1,100
endif

silent! colorscheme desert

if has('gui_running')
  colorscheme solarized

  if !exists('g:vimrc_loaded')
    set columns=90
    set lines=32
  endif

  set guioptions+=a
  set guioptions+=c
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T
  set guioptions-=b
  set guioptions-=e
  set guioptions-=f
  set guioptions-=l
  set guioptions-=m
  set guioptions-=r

  if has('mac')
    set guifont=Monaco:h12,Inconsolata:h15
  elseif has('unix')
    set guifont=Monospace\ 12
  elseif has('win32')
    set guifont=Consolas:h12:cANSI
    set linespace=0
  endif
endif

""""" General """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set clipboard+=unnamed
set fileformat=unix
set fileformats=unix,dos
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
set shortmess+=I
set ttyfast
set wildmode=list:longest,full

" Don't make mapped keys time out.
set notimeout ttimeout

if has('autochdir')
  set noautochdir
endif

if has('cindent')
  set cindent
endif

if has('folding')
  set foldclose=all
  set foldlevel=0
  set nofoldenable
endif

if has('vertsplit')
  set splitright
endif

if has('viminfo')
  set viminfo='1000,n$VIMHOME/viminfo
endif

if has('virtualedit')
  set virtualedit=block
endif

""""" Bell """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable audible and visual bell.
if has('gui_running')
  if has('autocmd')
    augroup disable_bell
      autocmd!
      autocmd GUIEnter * set noerrorbells visualbell t_vb=
    augroup end
  endif
else
  set noerrorbells visualbell t_vb=
endif

""""" Buffers """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! RefreshUI()

  if exists(':AirlineRefresh')
    AirlineRefresh
  else
    redraw!
    redrawstatus!
  endif

endfunction

function! SetCurrentBuffer()

  " Show buffer list.
  let l:more = &more
  set nomore
  echo
  ls
  let &more = l:more

  call inputsave()

  " Try asking the user for a buffer number or name.
  try
    let l:buffer = input("\nBuffer: ")
  catch /^Vim:Interrupt$/
    " Success: User issued CTRL-C.
    return 1
  finally
    call inputrestore()
  endtry

  " Try switching to the specified buffer.
  try
    execute 'buffer' l:buffer
  catch /^Vim\%((\a\+)\)\=:E86/
    " Failure: Buffer does not exist.
    return 0
  catch /^Vim\%((\a\+)\)\=:E93/
    " Failure: More than one match.
    return 0
  endtry

  return 1

endfunction

nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bb :call SetCurrentBuffer()<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bp :bp<CR>

""""" Indentation """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set default indentation options unless sourced.
if !exists('g:vimrc_loaded')
  set noexpandtab
  set shiftwidth=8
  set softtabstop=8
  set tabstop=8
  set textwidth=79
endif

""""" Mappings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Exit insert mode.
inoremap jj <ESC>

" Redo failed paste properly.
" 1) Undo last change.
" 2) Enable paste mode.
" 3) Repeat last change.
" 4) Disable paste mode.
" 5) Move cursor to last position in insert mode.
nnoremap <silent> <Leader>a u:set paste<CR>.:set nopaste<CR>gi

" Open .bashrc in current buffer.
nnoremap <silent> <Leader>eb :e! ~/.bashrc<CR>

" Open .gitconfig in current buffer.
nnoremap <silent> <Leader>eg :e! ~/.gitconfig<CR>

" Open .ssh/config in current buffer.
nnoremap <silent> <Leader>es :e! ~/.ssh/config<CR>

" Open .tmux.conf in current buffer.
nnoremap <silent> <Leader>et :e! ~/.tmux.conf<CR>

" Open .vimrc in current buffer.
nnoremap <silent> <Leader>ev :e! $MYVIMRC<CR>

""""" Symbols """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoreabbr mdefinedas ≜
inoreabbr mdelta ∂
inoreabbr melemin ∈
inoreabbr mequiv ≡
inoreabbr mexists ∃
inoreabbr mforall ∀
inoreabbr mgrequal ≥
inoreabbr miff ⇔
inoreabbr mifthen →
inoreabbr mimplies ⇒
inoreabbr minfinite ∞
inoreabbr mintersect ∩
inoreabbr mlequal ≤
inoreabbr mlogand ∨
inoreabbr mlognot ¬
inoreabbr mlogor ∧
inoreabbr mnequal ≠
inoreabbr mnotelemnin ∉
inoreabbr mprod ∏
inoreabbr msqrt √
inoreabbr msum ∑
inoreabbr mtherefore ∴
inoreabbr mthrow (╯°□°）╯︵ ┻━┻
inoreabbr munion ∪
inoreabbr mxor ⊕
inoreabbr samfisher ∴

""""" Filetypes """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('autocmd')
  augroup filetype_c
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal tabstop=8
  augroup end
  augroup filetype_help
    autocmd!
    autocmd FileType help setlocal keywordprg=:help
  augroup end
  augroup filetype_sieve
    autocmd!
    autocmd BufRead,BufNewFile *.sieve set filetype=sieve
    autocmd FileType sieve setlocal expandtab
    autocmd FileType sieve setlocal shiftwidth=2
    autocmd FileType sieve setlocal softtabstop=2
    autocmd FileType sieve setlocal tabstop=2
  augroup end
  augroup filetype_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source % | :call RefreshUI()
    autocmd FileType vim setlocal keywordprg=:help
  augroup end
  augroup filetype_yaml
    autocmd!
    autocmd BufRead,BufNewFile *.sls set filetype=yaml
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal tabstop=2
  augroup end
endif

let g:vimrc_loaded = 'yes'

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" vim:et:fen:fdm=marker:fmr={{,}}:fcl=all:fdl=0::ts=2:sw=2:sts=2:
