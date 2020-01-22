function! s:setup()
  setlocal shiftwidth=8
  setlocal tabstop=8
endfunction

autocmd BufNewFile,BufRead *.{c,h} setfiletype c
autocmd FileType c call s:setup()

