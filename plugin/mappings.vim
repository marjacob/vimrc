let mapleader = ","
let maplocalleader = ";"

nnoremap \ ,

set pastetoggle=<F2>

inoremap jk <Esc>
nnoremap <silent> <Leader>/ :set hlsearch!<CR>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bb :call buffer#set_current()<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>be :enew!<CR>
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bo :Explore<CR>
nnoremap <silent> <Leader>bp :bp<CR>
nnoremap <silent> <Leader>p :call buffer#redo_paste()<CR>
nnoremap <silent> <Leader>q :q<CR>
vnoremap <silent> <F10> :s/\s\+/\r/g<CR>
vnoremap <silent> <F9> :sort<CR>
vnoremap <silent> <S-F9> :sort!<CR>

" files
nnoremap <silent> <Leader>eb :e! ~/.bashrc<CR>
nnoremap <silent> <Leader>eg :e! ~/.gitconfig<CR>
nnoremap <silent> <Leader>ep :e! ~/.profile<CR>
nnoremap <silent> <Leader>es :e! ~/.ssh/config<CR>
nnoremap <silent> <Leader>et :e! ~/.tmux.conf<CR>
nnoremap <silent> <Leader>ev :e! $MYVIMRC<CR>
nnoremap <silent> <Leader>ez :e! ~/.zprofile<CR>

" norwegian
inoremap <silent> <Leader>E É
inoremap <silent> <Leader>e é
inoremap <silent> <Leader>" Æ
inoremap <silent> <Leader>' æ
inoremap <silent> <Leader>: Ø
inoremap <silent> <Leader>; ø
inoremap <silent> <Leader>[ å
inoremap <silent> <Leader>{ Å

" splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" timestamp
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
