" ..... boot .................................................................

if has('vim_starting')
  set nocompatible
  let mapleader = ","
  nnoremap \ ,
endif

" ..... main .................................................................

function! s:startup_cui()
  if has('title')
    set noicon
  endif
endfunction

function! s:startup_gui()
  call font#configure()
  set background=light
  silent! colorscheme solarized8

  " dimensions
  set columns=90
  set lines=32

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

  if has('win32')
    set linespace=0
    if has('directx')
      set renderoptions=type:directx
    endif
  endif
endfunction

" ..... startup ..............................................................

if has('vim_starting')
  call bell#disable()

  silent! language English_United States
  silent! language en_US
  silent! language English_United States.UTF-8
  silent! language en_US.UTF-8

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
  set ttyfast
  set wildmode=list:longest,full

  " Don't make mapped keys time out.
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

  if has('statusline')
    set laststatus=2
    set showtabline=2

    if empty(&g:statusline)
      set statusline=
            \[%n]
            \[%{mode()}]
            \%{&paste?'\ PASTE':''}
            \\ %<%.99f
            \\ %y%h%w%m%r%=%-14.(%l,%c%V%)
            \\ %P
    endif

    if has('title')
      set iconstring=
            \%{empty(v:servername)?v:progname\ :\ v:servername}
            \%{exists('$SSH_TTY')?'@'.hostname():''}
      set titlestring=
            \%{v:progname}
            \%(\ %)
            \%{empty(v:servername)?'':'--servername\ '.v:servername.'\ '}
            \%{fnamemodify(getcwd(),':~')}
            \%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
    endif
  endif

  if has('syntax')
    set colorcolumn=+1
  endif

  if has('vertsplit')
    set splitright
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
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bb :call buffer#set_current()<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>be :enew!<CR>
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bp :bp<CR>
nnoremap <silent> <Leader>eb :e! ~/.bashrc<CR>
nnoremap <silent> <Leader>eg :e! ~/.gitconfig<CR>
nnoremap <silent> <Leader>ep :e! ~/.profile<CR>
nnoremap <silent> <Leader>es :e! ~/.ssh/config<CR>
nnoremap <silent> <Leader>et :e! ~/.tmux.conf<CR>
nnoremap <silent> <Leader>ev :e! $MYVIMRC<CR>
nnoremap <silent> <Leader>p :call buffer#redo_paste()<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
vnoremap <silent> <Leader>s :sort<CR>

" ..... symbols ..............................................................

let s:symbols = {
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

" prabirshrestha/asyncomplete.vim
imap <C-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

if executable('pyls')
  " pip install python-language-server
  augroup lsp_python
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ })
  augroup end
endif

if executable('rls')
  " rustup update
  " rustup component add rls rust-analysis rust-src
  augroup lsp_rust
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'rls',
          \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
          \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
          \ 'whitelist': ['rust'],
          \ })
  augroup end
endif

" ............................................................................

let g:vimrc_loaded = 1

" ............................................................................
