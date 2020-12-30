function! s:cui()
  " Support true color in terminals other than xterm (e.g. tmux).
  if &term ==# "screen-256color"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endfunction

function! s:gui()
  set columns=111
  set lines=35

  if has('win32')
    set linespace=0
    if has('directx')
      set renderoptions=type:directx
    endif
  endif

  " Remove buttons, menus, scrollbars and other noise.
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

  call font#init()
endfunction

" No, seriously. I want English.
function! s:language()
  silent! language English_United States
  silent! language en_US
  silent! language English_United States.UTF-8
  silent! language en_US.UTF-8
endfunction

function! s:theme()
  let l:gui = has('gui_running')
  let l:tgc = 1

  " Try to enable support for 24-bit colors.
  if has('termguicolors')
    try
      set termguicolors
    catch /^Vim\%((\a\+)\)\=:E954/
      let l:tgc = 0
    endtry
  endif

  " Use Solarized or fall back to builtin color scheme.
  if l:gui || (&term =~ "-256color" && l:tgc)
    silent! colorscheme solarized8
  else
    silent! colorscheme blue
  endif

  let g:lightline = get(g:, 'lightline', {})
  let l:colorscheme = get(g:, 'colors_name', 'default')

  " Use matching lightline.vim theme.
  if l:colorscheme ==# 'blue'
    let g:lightline.colorscheme = 'Tomorrow_Night_Blue'
  elseif l:colorscheme ==# 'solarized8'
    let g:lightline.colorscheme = 'solarized'
  endif
endfunction

if has('gui_running')
  set background=light
  call s:gui()
else
  set background=dark
  call s:cui()
endif

call s:language()
call s:theme()
