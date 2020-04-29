function! s:setup()
  setlocal textwidth=72
  if has('syntax')
    setlocal spell
    setlocal spelllang=en_us
  endif
endfunction

autocmd FileType gitcommit call s:setup()

