" direnv.vim {{{ 
let g:direnv_auto = 0
let g:direnv_edit_mode = 'split'

" ?
let g:direnv_silent_load = 0
" }}} 

" vis {{{ 
" No clue where this should be for vis plugin to
" fuck off with it's maps
map <unique> <Leader>iws <Plug>SaveWinPos
map <unique> <Leader>iwr <Plug>RestoreWinPos
" }}} 

" TODO B vim-pandoc {{{ 
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#filetypes#handled = [
      \ 'markdown',
      \ 'pandoc',
      \ 'rst',
      \ ]
" }}} 

" {{{ other

" }}}
