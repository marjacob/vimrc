" ..... tex.vim ..............................................................

call language#norwegian()

setlocal autoindent
setlocal formatoptions=antw
setlocal textwidth=76

" Use tab as two spaces.
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Wrap lines on words, not characters.
setlocal linebreak
setlocal nolist
setlocal wrap

augroup ftplugin.after.tex
  autocmd!
  autocmd BufWritePre *.tex call format#text()
augroup end

