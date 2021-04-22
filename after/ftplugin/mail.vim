" Add trailing white space
" ------------------------
"	Add trailing white space to indicate that a paragraph continues in the next
"	line. A line that ends in a non-white character ends a paragraph. Setting
"	the text_flowed option in mutt can improve readability on small MUA screens.
"
"	See https://brianbuccola.com/line-breaks-in-mutt-and-vim/
"
setlocal formatoptions+=w

" Disable ALE for the current buffer
" ----------------------------------
" All trailing whitespace characters are removed automatically if the ALE
" fixer trim_whitespace is enabled globally. Disable ALE for mail buffers to
" prevent this.
"
let b:ale_enabled = 0

