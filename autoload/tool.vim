" ..... tool.vim .............................................................

function! tool#yapf()
  let l:candidates = ["yapf3", "yapf"]
  for candidate in l:candidates
    if executable(candidate) == 1
      return candidate
    endif
  endfor
  return ""
endfunction

