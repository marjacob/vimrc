" ..... tex.vim ..............................................................

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
nnoremap <buffer> <silent> <LocalLeader>p :call format#reflow()<CR>

augroup ftplugin.after.tex
  autocmd!
  autocmd BufWritePre <buffer> call format#text()
augroup end

if !exists('g:ale_fix_on_save')
  let b:ale_fix_on_save = 1
endif

if !exists('g:ale_lint_on_save')
  let b:ale_lint_on_save = 1
endif

let b:ale_linters = ['chktex']
