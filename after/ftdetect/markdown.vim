function s:format()
  let b:view = winsaveview()
  execute 'normal! gggqG'
  call winrestview(b:view)
  unlet b:view
endfunction

function! s:setup()
  setlocal autoindent
  setlocal formatoptions=antw
  setlocal textwidth=76

  " Use tab as four spaces.
  set expandtab
  set shiftwidth=4
  set softtabstop=4
  set tabstop=4

  " Wrap lines on words, not characters.
  setlocal linebreak
  setlocal nolist
  setlocal wrap

  " Support [æøåÆØÅ] with any keyboard layout.
  inoremap <buffer> <silent> <Leader>" Æ
  inoremap <buffer> <silent> <Leader>' æ
  inoremap <buffer> <silent> <Leader>: Ø
  inoremap <buffer> <silent> <Leader>; ø
  inoremap <buffer> <silent> <Leader>[ å
  inoremap <buffer> <silent> <Leader>{ Å

  " Generate Markdown headings.
  " See https://github.com/junegunn/dotfiles/blob/4330c45/vimrc#L494
  nnoremap <Leader>1 m`yypVr=``
  nnoremap <Leader>2 m`yypVr-``
  nnoremap <Leader>3 m`^i### <esc>``4l
  nnoremap <Leader>4 m`^i#### <esc>``5l
  nnoremap <Leader>5 m`^i##### <esc>``6l
endfunction

autocmd BufWritePre *.md call s:format()
autocmd FileType markdown call s:setup()

