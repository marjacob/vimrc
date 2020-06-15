" ..... font.vim .............................................................

function! s:font()
  if has('mac')
    return 'Monaco:h12'
  elseif has('win32')
    return 'Hack:h12,Consolas:h12,Courier New:h12'
  else
    return 'Monospace Medium 12'
  endif
endfunction

function! font#init()
  let &g:guifont=substitute(&g:guifont, '^$', s:font(), '')
endfunction

