" ..... ui.vim ...............................................................

function! s:cui()
  if has('title')
    set noicon
  endif
endfunction

function! s:gui()
  set columns=111
  set lines=35

  call font#init()

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

function! s:language()
  silent! language English_United States
  silent! language en_US
  silent! language English_United States.UTF-8
  silent! language en_US.UTF-8
endfunction

function! ui#init()
  call s:language()

  if has('gui_running')
    set background=light
    call s:gui()
  else
    set background=dark
    call s:cui()
  endif

  silent! colorscheme solarized8

  if get(g:, 'colors_name', 'default') ==# 'solarized8'
    let g:lightline = {'colorscheme': 'solarized',}
  endif
endfunction

