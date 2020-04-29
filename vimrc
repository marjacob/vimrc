" ..... boot .................................................................

if has('vim_starting')
  set nocompatible
  let mapleader = ","
  nnoremap \ ,
endif

" ..... cui ..................................................................

function! s:startup_cui()
  if has('title')
    set noicon
  endif
endfunction

" ..... gui ..................................................................

function! s:startup_gui()
  call font#configure()
  set background=light
  silent! colorscheme solarized8

  " dimensions
  set columns=111
  set lines=35

  " rendering
  if has('win32')
    set linespace=0
    if has('directx')
      set renderoptions=type:directx
    endif
  endif

  " window
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
endfunction

" ..... startup ..............................................................

if has('vim_starting')
  call bell#disable()
  call language#english()

  if get(g:, 'colors_name', 'default') ==# 'default'
    silent! colorscheme desert
  endif

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
  set scrolloff=5
  set shortmess+=I
  set splitbelow
  set splitright
  set ttyfast
  set wildmode=list:longest,full

  " no timeout for mapped keys
  set notimeout
  set ttimeout

  if has('autochdir')
    set noautochdir
  endif

  if has('cindent')
    set cindent
  endif

  if has('extra_search')
    set hlsearch
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

  if has('gui_running')
    call s:startup_gui()
  else
    call s:startup_cui()
  endif
endif

" ..... mappings .............................................................

set pastetoggle=<F2>

inoremap jj <ESC>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bb :call buffer#set_current()<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>be :enew!<CR>
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bp :bp<CR>
nnoremap <silent> <Leader>p :call buffer#redo_paste()<CR>
nnoremap <silent> <Leader>q :q<CR>
vnoremap <silent> <F10> :s/\s\+/\r/g<CR>
vnoremap <silent> <F9> :sort<CR>
vnoremap <silent> <S-F9> :sort!<CR>

" files
nnoremap <silent> <Leader>eb :e! ~/.bashrc<CR>
nnoremap <silent> <Leader>eg :e! ~/.gitconfig<CR>
nnoremap <silent> <Leader>ep :e! ~/.profile<CR>
nnoremap <silent> <Leader>es :e! ~/.ssh/config<CR>
nnoremap <silent> <Leader>et :e! ~/.tmux.conf<CR>
nnoremap <silent> <Leader>ev :e! $MYVIMRC<CR>
nnoremap <silent> <Leader>ez :e! ~/.zprofile<CR>

" splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" timestamp
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P

" ..... symbols ..............................................................

let s:symbols = {
      \'mapprox'     : '≈',
      \'mdefinedas'  : '≜',
      \'mdelta'      : '∂',
      \'melemin'     : '∈',
      \'mellipsis'   : '…',
      \'mequiv'      : '≡',
      \'mexists'     : '∃',
      \'mforall'     : '∀',
      \'mgrequal'    : '≥',
      \'miff'        : '⇔',
      \'mifthen'     : '→',
      \'mimplies'    : '⇒',
      \'minfinite'   : '∞',
      \'mintersect'  : '∩',
      \'mlequal'     : '≤',
      \'mlogand'     : '∨',
      \'mlognot'     : '¬',
      \'mlogor'      : '∧',
      \'mnequal'     : '≠',
      \'mnotelemnin' : '∉',
      \'mprod'       : '∏',
      \'mshrug'      : '¯\_(ツ)_/¯',
      \'msqrt'       : '√',
      \'msum'        : '∑',
      \'mtherefore'  : '∴',
      \'mthrow'      : '(╯°□°）╯︵ ┻━┻',
      \'mtimes'      : '×',
      \'munion'      : '∪',
      \'mxor'        : '⊕',
      \'samfisher'   : '∴',
      \}

for [lhs, rhs] in items(s:symbols)
  execute 'inoreabbrev' lhs rhs
endfor

" ..... plugins ..............................................................

" Raimondi/delimitMate
" Remove <> (<:>).
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = ""

" rust-lang/rust.vim
let g:rustfmt_autosave = 1

" prabirshrestha/asyncomplete.vim
imap <C-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'solarized'

" ..... autocommands .........................................................

augroup vimrc
  autocmd!
  " incsearch
  if exists('##CmdlineEnter') && exists('##CmdlineLeave')
    autocmd CmdlineEnter * set hlsearch
    autocmd CmdlineLeave * set nohlsearch
  endif

  " clang-format
  autocmd BufWritePre *.{c,c++,cc,cpp,cxx,h,h++,hh,hpp,hxx}
    \ :call clang#format()

augroup end

