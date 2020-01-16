" ~/.vimrc

set nocompatible
let mapleader = ","
nnoremap \ ,

" Try locale names from least to most wanted.
silent! language English_United States
silent! language en_US
silent! language English_United States.UTF-8
silent! language en_US.UTF-8

" ..... Encoding ..............................................................

if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf8
  setlocal fileencoding=utf-8
  setlocal fileencodings=utf-8,latin1,default
endif

" ..... Plugins ...............................................................

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

" Raimondi/delimitMate
" Remove <> (<:>).
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = ""

" prabirshrestha/asyncomplete.vim
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

" ..... Appearance ............................................................

set laststatus=2
set number
set numberwidth=5

if has('extra_search')
  set hlsearch
endif

if has('syntax')
  set colorcolumn=+1,99
endif

silent! colorscheme desert

if has('gui_running')
  colorscheme solarized
  set background=light

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
    set guifont=Fira\ Code:h11,Consolas:h12:cANSI
    set linespace=0

    " https://github.com/tonsky/FiraCode/issues/462
    if &encoding == 'utf-8' && &guifont =~? 'Fira Code'
      set renderoptions=type:directx
    endif
  endif
endif

" ..... General ...............................................................

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
set splitright
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

" ..... Bell ..................................................................

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

" ..... Buffers ...............................................................

" Redo failed paste properly.
function! RetryPaste()
  " Undo last change.
  execute 'normal u'
  " Enable paste mode.
  let l:paste = &paste
  set paste
  " Repeat last change.
  execute 'normal .'
  " Disable paste mode unless previously enabled.
  if paste == 0
      set nopaste
  endif
  " Move cursor to last position in insert mode.
  execute 'normal gi'
endfunction

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
nnoremap <silent> <Leader>bn :enew!<CR>
nnoremap <silent> <Leader>bp :bp<CR>

" ..... Indentation ...........................................................

" Set default indentation options unless sourced.
if !exists('g:vimrc_loaded')
  set noexpandtab
  set shiftwidth=8
  set softtabstop=8
  set tabstop=8
  set textwidth=79
endif

" ..... Mappings ..............................................................

" prabirshrestha/asyncomplete.vim
imap <C-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Split navigation mappings.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Support æøå with any keyboard layout.
inoremap <silent> <Leader>[ å
inoremap <silent> <Leader>' æ
inoremap <silent> <Leader>; ø

" Exit insert mode.
inoremap jj <ESC>

" Redo failed paste properly.
nnoremap <silent> <Leader>a :call RetryPaste()<CR>

" Open .bashrc in current buffer.
nnoremap <silent> <Leader>eb :e! ~/.bashrc<CR>

" Open .gitconfig in current buffer.
nnoremap <silent> <Leader>eg :e! ~/.gitconfig<CR>

" Open .profile in current buffer.
nnoremap <silent> <Leader>ep :e! ~/.profile<CR>

" Open .ssh/config in current buffer.
nnoremap <silent> <Leader>es :e! ~/.ssh/config<CR>

" Open .tmux.conf in current buffer.
nnoremap <silent> <Leader>et :e! ~/.tmux.conf<CR>

" Open .vimrc in current buffer.
nnoremap <silent> <Leader>ev :e! $MYVIMRC<CR>

" Quit mappings.
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>q :q<CR>

" ..... Symbols ...............................................................

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
inoreabbr mshrug ¯\_(ツ)_/¯
inoreabbr msqrt √
inoreabbr msum ∑
inoreabbr mtherefore ∴
inoreabbr mthrow (╯°□°）╯︵ ┻━┻
inoreabbr munion ∪
inoreabbr mxor ⊕
inoreabbr samfisher ∴

" ..... Filetypes .............................................................

if has('autocmd')
  augroup filetype_c
    autocmd!
    autocmd BufNewFile,BufRead *.h setlocal filetype=c
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal tabstop=8
  augroup end
  augroup filetype_help
    autocmd!
    autocmd FileType help setlocal keywordprg=:help
  augroup end
  augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal colorcolumn=""
    autocmd FileType markdown setlocal linebreak nolist wrap
  augroup end
  augroup filetype_python
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal filetype=python
    autocmd FileType python autocmd BufWritePre <buffer> 0,$!yapf
    autocmd FileType python nnoremap <buffer> <leader>f :0,$!yapf<Cr><C-o>
    autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal fileformat=unix
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal textwidth=79
  augroup end
  augroup filetype_sieve
    autocmd!
    autocmd BufNewFile,BufRead *.sieve setlocal filetype=sieve
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
    autocmd BufNewFile,BufRead *.sls setlocal filetype=yaml
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal tabstop=2
  augroup end
endif

let g:vimrc_loaded = 1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" vim:et:fen:fdm=marker:fmr={{,}}:fcl=all:fdl=0::ts=2:sw=2:sts=2:
