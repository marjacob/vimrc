function s:format()
  let b:view = winsaveview()
  execute 'normal! gggqG'
  keeppatterns %s/\s\+$//e
  call winrestview(b:view)
endfunction

function! s:setup()
  call language#norwegian()

  setlocal autoindent
  setlocal formatoptions=antw
  setlocal textwidth=76

  " Use tab as four spaces.
  setlocal expandtab
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4

  " Wrap lines on words, not characters.
  setlocal linebreak
  setlocal nolist
  setlocal wrap

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

