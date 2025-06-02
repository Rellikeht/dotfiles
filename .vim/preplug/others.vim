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

" vim-sneak {{{ 

" TODO colors
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = '  < sneak > '
let g:sneak#s_next = 0

" }}} 

" Repeat {{{ 

" https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/
" https://vi.stackexchange.com/questions/20760/how-to-add-a-count-to-a-binding

" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" Because that does't work with cgn and
" probably some other mappings

" map ;. <Plug>(RepeatDot)
map . <Plug>(RepeatDot)
noremap ;. .

" }}} 

" unicode {{{ 
" TODO B is this complete ?

let g:Unicode_no_default_mappings = 1

inoremap <C-x><C-g> <Plug>(DigraphComplete)
inoremap <C-x><C-a> <Plug>(UnicodeComplete)
inoremap <C-x><C-h> <Plug>(HTMLEntityComplete)
inoremap <C-x><C-s> <Plug>(UnicodeFuzzy)

imap <C-x>g <C-x><C-g>
imap <C-x>a <C-x><C-a>
imap <C-x>h <C-x><C-h>
imap <C-x>s <C-x><C-s>

inoremap <expr> <C-a> pumvisible() ? '<C-n>' : '<C-a>'
inoremap <expr> <C-h> pumvisible() ? '<C-n>' : '<C-h>'

noremap <Leader>nm <Plug>(MakeDigraph)
nnoremap ga <Plug>(UnicodeGA)

" }}} 

" other {{{

" for matchup
let g:loaded_matchit = 1

let g:git_messenger_no_default_mappings = 1

" This has to be mapped for plugin not to map it
map <unique> <Leader>iws <Plug>SaveWinPosn
map <unique> <Leader>iwr <Plug>RestoreWinPosn

let g:wheel#line#threshold = 2*&scrolloff " lines from start or end

let g:accelerated_jk_acceleration_limit = 250
let g:accelerated_jk_enable_deceleration = 1
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" alt really, but this seems the only way to map this
let g:wheel#map#up   = '<Esc>k'
let g:wheel#map#down = '<Esc>j'
nnoremap <Esc><Esc> <Esc>

" }}}
