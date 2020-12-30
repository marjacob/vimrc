" asyncomplete.vim
" https://github.com/prabirshrestha/asyncomplete.vim

imap <C-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
