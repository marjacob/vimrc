" ..... format.vim ...........................................................

function! s:endline()
  if getline('$') !~ "^$"
    call append(line('$'), '')
  endif
endfunction

function! format#code()
  let l:view = winsaveview()
  execute 'normal! gg=G'
  keeppatterns %s/\s\+$//e
  call s:endline()
  call winrestview(l:view)
endfunction

function! format#text()
  let l:view = winsaveview()
  execute 'normal! gggqG'
  keeppatterns %s/\s\+$//e
  call s:endline()
  call winrestview(l:view)
endfunction
