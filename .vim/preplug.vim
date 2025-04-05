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

" makeshift {{{

let g:makeshift_on_startup = 0
let g:makeshift_on_bufread = 0
let g:makeshift_on_bufnewfile = 0
let g:makeshift_on_bufenter = 0
let g:makeshift_chdir = 0
" To try the build file in the current directory before searching from the file directory:
let g:makeshift_use_pwd_first = 1
" To enable search for bundled build program/script:
let g:makeshift_find_bundled = 1

" TODO B nimble, cmake, dune, go, and probably bunch of others
let g:makeshift_systems = {
    \ 'meson.build': 'meson',
    \ }

" }}}

" {{{ other

" }}}
