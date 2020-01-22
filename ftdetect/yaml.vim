function! s:setup()
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
endfunction

autocmd BufNewFile,BufRead *.sls setfiletype yaml
autocmd FileType yaml call s:setup()

