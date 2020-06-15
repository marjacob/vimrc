" ..... tex.vim ..............................................................

function s:reflow()
  let l:view = winsaveview()
  execute 'normal! vipJvipgq'
  keeppatterns %s/\%V\s\+\%V/ /g
  call winrestview(l:view)
endfunction

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

nnoremap <buffer> <silent> <LocalLeader>f :call format#text()<CR>
nnoremap <buffer> <silent> <LocalLeader>p :call <SID>reflow()<CR>

augroup ftplugin.after.tex
  autocmd!
  autocmd BufWritePre <buffer> call format#text()
augroup end

