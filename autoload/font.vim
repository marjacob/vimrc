" ..... font.vim .............................................................

function! s:font()
  if has('mac')
    return 'Monaco:h9'
  elseif has('win32')
    return 'Consolas:h9,Courier New:h8'
  else
    return 'Monospace Medium 9'
  endif
endfunction

function! font#configure()
  let &g:guifont=substitute(&g:guifont, '^$', s:font(), '')
endfunction

