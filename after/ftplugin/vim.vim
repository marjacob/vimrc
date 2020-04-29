function! s:refresh()
  redraw!
  redrawstatus!
endfunction

function! s:setup()
  setlocal expandtab
  setlocal keywordprg=:help
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  if has('win32')
    setlocal makeprg=%:h\make.cmd
  else
    setlocal makeprg=make\ -C\ %:h
  endif
endfunction

autocmd BufWritePost $MYVIMRC so % | call s:refresh()
autocmd FileType vim call s:setup()

