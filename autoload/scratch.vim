" ..... scratch.vim ..........................................................

function! scratch#show(name, lines)
  let number = bufwinnr(a:name)

  if number > 0
    " move to existing window
    silent execute number . 'wincmd w'
    setlocal modifiable
    :%d
  else
    " create new window
    silent execute a:lines . 'split ' . a:name
  endif

  " make scratch window
  " :h special-buffers
  setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal nonumber
  setlocal noswapfile

  if has("syntax")
    setlocal colorcolumn=
    setlocal cursorline
  endif

  nnoremap <buffer> <silent> <Esc> :bdelete!<CR>

  augroup yapf
    autocmd!
    autocmd BufLeave <buffer> bdelete!
  augroup end

  return bufnr('%')
endfunction

