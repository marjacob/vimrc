" ..... python.vim ...........................................................

setlocal autoindent
setlocal expandtab
setlocal fileformat=unix
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=79

nnoremap <buffer> <leader>f :0,$!yapf<Cr><C-o>

augroup ftplugin.after.python
  autocmd!
  autocmd BufWritePre <buffer> 0,$!yapf
augroup end

