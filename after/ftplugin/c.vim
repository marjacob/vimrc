" ..... c.vim ................................................................

setlocal shiftwidth=8
setlocal tabstop=8

augroup ftplugin.after.c
  autocmd!
  autocmd BufWritePre *.{c,h} call format#clang()
augroup end

