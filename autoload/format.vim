" ..... format.vim ...........................................................

function! s:endline()
  if getline('$') !~ "^$"
    call append(line('$'), '')
  endif
endfunction

function! s:error(message) abort
  echohl ErrorMsg
  redrawstatus
  echomsg a:message
  echohl None
endfunction

function! s:formatter_failed(formatter)
  call s:error("Formatter \'" . a:formatter . "\' failed")
endfunction

function! s:formatter_missing(formatter)
  call s:error("Missing formatter \'" . a:formatter . "\'")
endfunction

function! format#clang()
  let l:formatter = 'clang-format'
  if executable(l:formatter)
    let l:view = winsaveview()
    :%!clang-format
    call s:endline()
    call winrestview(l:view)
  else
    call s:formatter_missing(l:formatter)
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

function! s:yapf(name)
  let l:view = winsaveview()
  silent execute '0,$!' . a:name
  if v:shell_error
    let l:savereg = @a
    silent execute ':0,$y a'
    silent undo
    call winrestview(l:view)
    call scratch#show("YAPF", 4)
    silent normal! "aPG_dd
    let @a = l:savereg
    setlocal nomodifiable
  else
    call winrestview(l:view)
  endif
endfunction

function! format#yapf()
  let l:formatter = tool#yapf()
  if empty(l:formatter)
    call s:formatter_missing("YAPF")
  else
    call s:yapf(l:formatter)
  endif
endfunction

