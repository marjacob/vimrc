" ..... language.vim .........................................................

function! language#english()
  silent! language English_United States
  silent! language en_US
  silent! language English_United States.UTF-8
  silent! language en_US.UTF-8
endfunction

function! language#norwegian()
  inoremap <buffer> <silent> <Leader>" Æ
  inoremap <buffer> <silent> <Leader>' æ
  inoremap <buffer> <silent> <Leader>: Ø
  inoremap <buffer> <silent> <Leader>; ø
  inoremap <buffer> <silent> <Leader>[ å
  inoremap <buffer> <silent> <Leader>{ Å
endfunction

