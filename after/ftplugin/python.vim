" ..... python.vim ...........................................................

setlocal autoindent
setlocal expandtab
setlocal fileformat=unix
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=79

nnoremap <buffer> <silent> <LocalLeader>f :call format#yapf()<CR>

augroup ftplugin.after.python
  autocmd!
  autocmd BufWritePre <buffer> call format#yapf()
augroup end

