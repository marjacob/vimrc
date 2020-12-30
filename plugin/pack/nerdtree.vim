" nerdtree
" https://github.com/preservim/nerdtree

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeIgnore = ['\c^ntuser\..*', '\~$']
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinPos = "right"

nnoremap <silent> <C-f> :NERDTreeFind<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
