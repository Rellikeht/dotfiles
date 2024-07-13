" {{{ heavy stuff

let mapleader = ','
autocmd FileType * let b:match_ignorecase = 0

" ?
autocmd VimEnter * arglocal!

set secure
" shitty, but works somehow
autocmd BufReadPost *
    \ if &ft == ""
    \ | filetype detect
    \ | endif
    \ | if &ft == ""
    \ | setlocal modeline
    \ | endif

set shortmess=at
set cmdheight=2

" }}}

" TODO tabline, statusline

" {{{ some simple settings

nnoremap <Leader><Space><Space> :setlocal hls!<CR>
vnoremap <Leader><Space><Space> :setlocal hls!\|norm gv<CR>
nnoremap <Leader>qen :set relativenumber!<CR>
vnoremap <Leader>qen :set relativenumber!\|norm gv<CR>
nnoremap <Leader>qeN :set number!<CR>
vnoremap <Leader>qeN :set number!\|norm gv<CR>
nnoremap <Leader>qeC :set cursorbind!<CR>
vnoremap <Leader>qeC :set cursorbind!\|norm gv<CR>
nnoremap <Leader>qep :set paste!<CR>
vnoremap <Leader>qep :set paste!\|norm gv<CR>

set cursorline

nnoremap <Leader>qec :set cursorline!<CR>
vnoremap <Leader>qec :set cursorline!\|norm gv<CR>

" TODO confirmation maybe?
nnoremap <Leader>qkw :call Wmt()<CR>
vnoremap <Leader>qkw :call Wmt()\|norm gv<CR>
nnoremap <silent> <Leader>qpm :call ToggleManProg()<CR>
vnoremap <silent> <Leader>qpm :call ToggleManProg()\|norm gv<CR>
nnoremap <Leader>qpM :set makeprg=make<CR>
vnoremap <Leader>qpM :set makeprg=make\|norm gv<CR>

nnoremap <Leader>qet :filetype detect<CR>
vnoremap <Leader>qet :filetype detect\|norm gv<CR>
noremap <Leader>qeT :set filetype=
nnoremap <Leader>qeh :set hls!<CR>
vnoremap <Leader>qeh :set hls!\|norm gv<CR>

" }}}

"{{{ automatic formatting and compiling control

let g:buffmt = 1
let g:bufcomp = 0
autocmd FileType * let b:buffmt = g:buffmt
autocmd FileType * let b:bufcomp = g:bufcomp

nnoremap <Leader>qff :let b:buffmt=!b:buffmt<CR>
vnoremap <Leader>qff :let b:buffmt=!b:buffmt\|norm gv<CR>
nnoremap <Leader>qfF :let g:buffmt=!g:buffmt<CR>
vnoremap <Leader>qfF :let g:buffmt=!g:buffmt\|norm gv<CR>
nnoremap <Leader>qv1 :echo b:buffmt<CR>
vnoremap <Leader>qv1 :echo b:buffmt\|norm gv<CR>

nnoremap <Leader>qfc :let b:bufcomp=!b:bufcomp<CR>
vnoremap <Leader>qfc :let b:bufcomp=!b:bufcomp\|norm gv<CR>
nnoremap <Leader>qfC :let g:bufcomp=!g:bufcomp<CR>
vnoremap <Leader>qfC :let g:bufcomp=!g:bufcomp\|norm gv<CR>
nnoremap <Leader>qv2 :echo b:bufcomp<CR>
vnoremap <Leader>qv2 :echo b:bufcomp\|norm gv<CR>

"}}}

" {{{ nontrivial settings

autocmd BufRead * let b:vautowrite = g:vautowrite

" v in front of variables that have names similar to settings they control
let g:vautoread = 0
let g:vautowrite = 0
autocmd FileType * let b:vautoread = g:vautoread
autocmd FileType * let b:vautowrite = g:vautowrite

nnoremap <Leader>qfr :call ToggleBuffer('autoread')<CR>
vnoremap <Leader>qfr :call ToggleBuffer('autoread')\|norm gv<CR>
nnoremap <Leader>qfR :let g:vautoread=!g:vautoread<CR>
vnoremap <Leader>qfR :let g:vautoread=!g:vautoread\|norm gv<CR>
nnoremap <Leader>qv3 :echo b:vautoread<CR>
vnoremap <Leader>qv3 :echo b:vautoread\|norm gv<CR>

nnoremap <Leader>qfw :call ToggleBuffer('autowrite')<CR>
vnoremap <Leader>qfw :call ToggleBuffer('autowrite')\|norm gv<CR>
nnoremap <Leader>qfW :let g:vautowrite=!g:vautowrite<CR>
vnoremap <Leader>qfW :let g:vautowrite=!g:vautowrite\|norm gv<CR>
nnoremap <Leader>qv4 :echo b:vautowrite<CR>
vnoremap <Leader>qv4 :echo b:vautowrite\|norm gv<CR>

" TODO
" let g:autoupdate = 0
" autocmd FileType * let b:autoupdate = g:autoupdate

" noremap <Leader>qfu :call ToggleAutoupdate()<CR>
" noremap <Leader>qfU :let g:autoupdate=!g:autoupdate<CR>
" noremap <Leader>qv5 :echo b:autoupdate<CR>

" }}}

" {{{ other

let g:autochdir = 0
silent! call ToggleAutochdir()

nnoremap <Leader>qca :call ToggleAutochdir()<CR>
vnoremap <Leader>qca :call ToggleAutochdir()\|norm gv<CR>

" }}}
