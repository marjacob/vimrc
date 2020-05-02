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
  call s:error('Formatter ''' . a:formatter . ''' failed')
endfunction

function! s:formatter_missing(formatter)
  call s:error('Missing formatter ''' . a:formatter . '''')
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

function! format#yapf()
  let l:formatter = 'yapf'
  if executable(l:formatter)
    let l:view = winsaveview()
    silent execute '0,$!' . l:formatter
    if v:shell_error != 0
      silent undo
      call s:formatter_failed(l:formatter)
    endif
    call winrestview(l:view)
  else
    call s:formatter_missing(l:formatter)
  endif
endfunction

