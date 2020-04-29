function! s:setup()
  setlocal autoindent
  setlocal expandtab
  setlocal fileformat=unix
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
  setlocal textwidth=79

  nnoremap <buffer> <leader>f :0,$!yapf<Cr><C-o>

  augroup ftdetect_python
    autocmd!
    autocmd BufWritePre <buffer> 0,$!yapf
  augroup end
endfunction

autocmd FileType python call s:setup()

