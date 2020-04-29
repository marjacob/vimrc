function s:format()
  let b:view = winsaveview()
  execute 'normal! gggqG'
  keeppatterns %s/\s\+$//e
  call winrestview(b:view)
endfunction

function! s:setup()
  call language#norwegian()

  setlocal autoindent
  setlocal formatoptions=antw
  setlocal textwidth=76

  " Use tab as two spaces.
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2

  " Wrap lines on words, not characters.
  setlocal linebreak
  setlocal nolist
  setlocal wrap
endfunction

autocmd BufWritePre *.tex call s:format()
autocmd FileType tex call s:setup()

