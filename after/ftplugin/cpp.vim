" ..... cpp.vim ..............................................................

setlocal shiftwidth=8
setlocal tabstop=8

augroup ftplugin.after.cpp
  autocmd!
  autocmd BufWritePre *.{c++,cc,cpp,cxx,h++,hh,hpp,hxx} call format#clang()
augroup end

