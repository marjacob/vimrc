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
