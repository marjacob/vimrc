" ..... c.vim ................................................................

setlocal shiftwidth=8
setlocal tabstop=8

nnoremap <buffer> <silent> <LocalLeader>f :call format#clang()<CR>

augroup ftplugin.after.c
  autocmd!
  autocmd BufWritePre <buffer> call format#clang()
augroup end

