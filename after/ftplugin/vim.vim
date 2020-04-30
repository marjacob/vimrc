" ..... vim.vim ..............................................................

function! s:refresh()
  redraw!
  redrawstatus!
endfunction

setlocal expandtab
setlocal keywordprg=:help
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

if has('win32')
  setlocal makeprg=%:h\make.cmd
else
  setlocal makeprg=make\ -C\ %:h
endif

augroup ftplugin.after.vim
  autocmd!
  autocmd BufWritePost $MYVIMRC so % | call s:refresh()
  autocmd BufWritePre $MYVIMRC,*.vim call format#code()
augroup end

