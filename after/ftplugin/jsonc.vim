" ..... jsonc.vim ............................................................

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

nnoremap <buffer> <silent> <LocalLeader>f :call format#code()<CR>

augroup ftplugin.after.vim
  autocmd!
  autocmd BufWritePre <buffer> call format#code()
augroup end
