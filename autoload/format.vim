" ..... format.vim ...........................................................

function! s:endline()
  if getline('$') !~ "^$"
    call append(line('$'), '')
  endif
endfunction

function! format#clang()
  if executable('clang-format')
    let b:view = winsaveview()
    :%!clang-format
    call s:endline()
    call winrestview(b:view)
  endif
endfunction

function! format#code()
  let b:view = winsaveview()
  execute 'normal! gg=G'
  keeppatterns %s/\s\+$//e
  call s:endline()
  call winrestview(b:view)
endfunction

function! format#text()
  let b:view = winsaveview()
  execute 'normal! gggqG'
  keeppatterns %s/\s\+$//e
  call s:endline()
  call winrestview(b:view)
endfunction

