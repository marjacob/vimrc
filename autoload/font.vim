" ..... font.vim .............................................................

function! s:font()
  if has('mac')
    return 'Monaco:h12'
  elseif has('win32')
    return 'Consolas:h11,Courier New:h10'
  else
    return 'Monospace Medium 11'
  endif
endfunction

function! font#configure()
  let &g:guifont=substitute(&g:guifont, '^$', s:font(), '')
endfunction

