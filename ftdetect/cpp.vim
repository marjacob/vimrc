function! s:setup()
  setlocal shiftwidth=8
  setlocal tabstop=8
endfunction

autocmd BufNewFile,BufRead *.{c++,cc,cpp,cxx,h++,hh,hxx,hpp} setfiletype cpp
autocmd FileType cpp call s:setup()

