" ..... c.vim ................................................................

setlocal shiftwidth=8
setlocal tabstop=8

if !exists('g:ale_fix_on_save')
  let b:ale_fix_on_save = 1
endif

let b:ale_fixers = ['clang-format']
