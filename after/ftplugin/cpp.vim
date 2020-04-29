function! s:setup()
  setlocal shiftwidth=8
  setlocal tabstop=8
endfunction

autocmd FileType cpp call s:setup()

