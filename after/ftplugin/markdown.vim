" ..... markdown.vim .........................................................

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
nnoremap <buffer> <LocalLeader>1 m`yypVr=``
nnoremap <buffer> <LocalLeader>2 m`yypVr-``
nnoremap <buffer> <LocalLeader>3 m`^i### <esc>``4l
nnoremap <buffer> <LocalLeader>4 m`^i#### <esc>``5l
nnoremap <buffer> <LocalLeader>5 m`^i##### <esc>``6l

nnoremap <buffer> <silent> <LocalLeader>f :call format#text()<CR>
nnoremap <buffer> <silent> <LocalLeader>p :call format#reflow()<CR>

augroup ftplugin.after.markdown
  autocmd!
  autocmd BufWritePre <buffer> call format#text()
augroup end
