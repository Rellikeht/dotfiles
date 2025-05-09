" direnv.vim {{{ 
let g:direnv_auto = 0
let g:direnv_edit_mode = 'split'

" ?
let g:direnv_silent_load = 0
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
" TODO B maybe just all of them need some magical wrapper to
" find build directory, because they can't find it by themeselves
let g:makeshift_systems = {
    \ 'meson.build': 'auto-meson',
    \ 'CMakeLists.txt': 'auto-cmake',
    \ }
    " \ 'meson.build': 'meson',

" }}}

" {{{ other

" for matchup
let g:loaded_matchit = 1

" }}}
