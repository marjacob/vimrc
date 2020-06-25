" ..... python.vim ...........................................................

setlocal autoindent
setlocal expandtab
setlocal fileformat=unix
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=79

if !exists('g:ale_fix_on_save')
  let b:ale_fix_on_save = 1
endif

" debian:
" $ sudo apt install python3 python3-pip
" $ sudo pip3 install python-language-server reorder-python-imports yapf

let b:ale_fixers = [
      \ 'add_blank_lines_for_python_control_statements',
      \ 'remove_trailing_lines',
      \ 'reorder-python-imports',
      \ 'trim_whitespace',
      \ 'yapf'
      \ ]
