" ..... buffer.vim ...........................................................

" Set current buffer interactively.
function! buffer#set_current()
  " Show buffer list.
  let l:more = &more
  set nomore
  echo
  ls
  let &more = l:more

  call inputsave()

  " Try asking the user for a buffer number or name.
  try
    let l:buffer = input("\nBuffer: ")
  catch /^Vim:Interrupt$/
    return 1 " User issued CTRL-C.
  finally
    call inputrestore()
  endtry

  " Try switching to the specified buffer.
  try
    execute 'buffer' l:buffer
  catch /^Vim\%((\a\+)\)\=:E86/
    return 0 " Buffer does not exist.
  catch /^Vim\%((\a\+)\)\=:E93/
    return 0 " More than one match.
  endtry

  return 1
endfunction

" Redo failed paste properly.
function! buffer#redo_paste()
  " Undo last change.
  execute 'normal u'

  " Enable paste mode.
  let l:paste = &paste
  set paste

  " Repeat last change.
  execute 'normal .'

  " Disable paste mode unless previously enabled.
  if paste == 0
    set nopaste
  endif

  " Move cursor to last position in insert mode.
  execute 'normal gi'
endfunction

