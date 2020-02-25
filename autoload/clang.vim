" ..... clang.vim ...........................................................

function! clang#format()
  if executable('clang-format')
    let b:view = winsaveview()
    :%!clang-format
    if getline('$') !~ "^$"
        call append(line('$'), '')
    endif
    call winrestview(b:view)
  endif
endfunction

