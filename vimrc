" ~/.vimrc
" ............................................................................

if has('vim_starting')
  set nocompatible
  set pastetoggle=<F2>

  " Leader
  let mapleader = ","
  nnoremap \ ,
endif

" ..... Encoding .............................................................

set encoding=utf-8     " Encoding displayed.
set fileencoding=utf-8 " Encoding written to file.

" ..... Appearance ...........................................................

function! s:font()
  if has('mac')
    return 'Monaco:h12'
  elseif has('win32')
    return 'Consolas:h11,Courier New:h10'
  else
    return 'Monospace Medium 12'
  endif
endfunction

function! s:startup_cui()
  if has('title')
    set noicon
  endif
endfunction

function! s:startup_gui()
  set background=light
  silent! colorscheme solarized8

  if has('directx')
    set renderoptions=type:directx
  endif

  if has('win32')
    set linespace=0
  endif

  " Hide superfluous user interface elements.
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

  " Set initial window dimensions.
  set columns=90
  set lines=32

  " Set window font.
  let &g:guifont=substitute(&g:guifont, '^$', s:font(), '')
endfunction

if has('vim_starting')
  " Try locales in order from least to most preferred.
  silent! language English_United States
  silent! language en_US
  silent! language English_United States.UTF-8
  silent! language en_US.UTF-8

  " Set fallback color scheme.
  if get(g:, 'colors_name', 'default') ==# 'default'
    silent! colorscheme desert
  endif

  if has('extra_search')
    set hlsearch
    set incsearch
  endif

  if has('syntax')
    set colorcolumn=+1
  endif

  set cmdheight=2

  " Display line numbers.
  set number
  set numberwidth=5

  " Set default indentation options.
  set noexpandtab
  set shiftwidth=8
  set softtabstop=8
  set tabstop=8
  set textwidth=78

  if has('statusline')
    set laststatus=2
    set showtabline=2

    if empty(&g:statusline)
      set statusline=[%n]\ %<%.99f\ %y%h%w%m%r%=%-14.(%l,%c%V%)\ %P
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

  if has('autocmd')
    augroup startup
      autocmd!
      autocmd VimEnter * if !has('gui_running') | call s:startup_cui() | endif
      autocmd GUIEnter * call s:startup_gui()
    augroup end
  else
    if has('gui_running')
      call s:startup_gui()
    else
      call s:startup_cui()
    endif
  endif
endif

" ..... Bell .................................................................

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

" ..... Plugins ..............................................................

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

" ..... General ..............................................................

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

" ..... Buffers ..............................................................

" Redo failed paste properly.
function! s:retry_paste()
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

function! s:refresh_ui()
  redraw!
  redrawstatus!
endfunction

function! s:set_current_buffer()
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
    return 1 " User issued CTRL-C.
  finally
    call inputrestore()
  endtry

  " Try switching to the specified buffer.
  try
    execute 'buffer' l:buffer
  catch /^Vim\%((\a\+)\)\=:E86/
    return 0 " Buffer does not exist.
  catch /^Vim\%((\a\+)\)\=:E93/
    return 0 " More than one match.
  endtry

  return 1
endfunction

" ..... Mappings .............................................................

inoremap jj <ESC>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>a :call <SID>retry_paste()<CR>
nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bb :call <SID>set_current_buffer()<CR>
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
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
vnoremap <silent> <Leader>s :sort<CR>

" prabirshrestha/asyncomplete.vim
imap <C-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" ..... Symbols ..............................................................

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

" ..... Filetypes ............................................................

function! s:filetype_c()
  setlocal shiftwidth=8
  setlocal tabstop=8
endfunction

function! s:filetype_cpp()
  setlocal shiftwidth=8
  setlocal tabstop=8
endfunction

function! s:filetype_help()
  setlocal keywordprg=:help
endfunction

function! s:filetype_markdown()
  setlocal colorcolumn=77
  setlocal linebreak nolist wrap
  setlocal textwidth=76

  " Support [æøåÆØÅ] with any keyboard layout.
  inoremap <buffer> <silent> <Leader>" Æ
  inoremap <buffer> <silent> <Leader>' æ
  inoremap <buffer> <silent> <Leader>: Ø
  inoremap <buffer> <silent> <Leader>; ø
  inoremap <buffer> <silent> <Leader>[ å
  inoremap <buffer> <silent> <Leader>{ Å

  nnoremap <Leader>1 m`yypVr=``
  nnoremap <Leader>2 m`yypVr-``
  nnoremap <Leader>3 m`^i### <esc>``4l
  nnoremap <Leader>4 m`^i#### <esc>``5l
  nnoremap <Leader>5 m`^i##### <esc>``6l
endfunction

function! s:filetype_python()
  setlocal autoindent
  setlocal expandtab
  setlocal fileformat=unix
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
  setlocal textwidth=79

  nnoremap <buffer> <leader>f :0,$!yapf<Cr><C-o>

  augroup filetype_python
    autocmd!
    autocmd BufWritePre <buffer> 0,$!yapf
  augroup end
endfunction

function! s:filetype_sieve()
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
endfunction

function! s:filetype_vim()
  setlocal keywordprg=:help
  if has('win32')
    setlocal makeprg=%:h\make.cmd
  else
    setlocal makeprg=make -C %:h
  endif
endfunction

function! s:filetype_yaml()
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
endfunction

if has('autocmd')
  augroup filetypes
    au!
    " C
    au BufNewFile,BufRead *.{c,h} setl ft=c
    au FileType c call <SID>filetype_c()
    " C++
    au BufNewFile,BufRead *.{c++,cc,cpp,cxx,h++,hh,hxx,hpp} setl ft=cpp
    au FileType cpp call <SID>filetype_cpp()
    " Help
    au FileType help call <SID>filetype_help()
    " Markdown
    au FileType markdown call <SID>filetype_markdown()
    " Python
    au FileType python call <SID>filetype_python()
    " Sieve
    au BufNewFile,BufRead *.sieve setl ft=sieve
    au FileType sieve call <SID>filetype_sieve()
    " Vim
    au BufWritePost $MYVIMRC so % | call <SID>refresh_ui()
    au FileType vim call <SID>filetype_vim()
    " YAML
    au BufNewFile,BufRead *.sls setl ft=yaml
    au FileType yaml call <SID>filetype_yaml()
  augroup end
endif

" ............................................................................

let g:vimrc_loaded = 1

" ............................................................................
" vim:et:fen:fdm=marker:fmr={{,}}:fcl=all:fdl=0::ts=2:sw=2:sts=2:
