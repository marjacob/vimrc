function! s:setup()
  setlocal keywordprg=:help
endfunction

autocmd FileType help call s:setup()

