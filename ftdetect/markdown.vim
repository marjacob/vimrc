function s:format()
  let b:view = winsaveview()
  execute 'normal! gggqG'
  call winrestview(b:view)
  unlet b:view
endfunction

function! s:setup()
  setlocal autoindent
  setlocal formatoptions=antw
  setlocal linebreak nolist wrap
  setlocal textwidth=76

  " Support [æøåÆØÅ] with any keyboard layout.
  inoremap <buffer> <silent> <Leader>" Æ
  inoremap <buffer> <silent> <Leader>' æ
  inoremap <buffer> <silent> <Leader>: Ø
  inoremap <buffer> <silent> <Leader>; ø
  inoremap <buffer> <silent> <Leader>[ å
  inoremap <buffer> <silent> <Leader>{ Å

  nnoremap <Leader>1 m`yypVr=``
  nnoremap <Leader>2 m`yypVr-``
  nnoremap <Leader>3 m`^i### <esc>``4l
  nnoremap <Leader>4 m`^i#### <esc>``5l
  nnoremap <Leader>5 m`^i##### <esc>``6l
endfunction

autocmd BufWritePre *.md call s:format()
autocmd FileType markdown call s:setup()

