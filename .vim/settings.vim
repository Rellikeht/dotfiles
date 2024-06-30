let mapleader = ','

autocmd FileType * let b:match_ignorecase = 0

" Some simple settings
nnoremap <Leader><Space> :set hls!<CR>
noremap <Leader>qen :set relativenumber!<CR>
noremap <Leader>qeN :set number!<CR>
noremap <Leader>qeC :set cursorbind!<CR>

" TODO confirmation maybe?
noremap <Leader>qkw :call Wmt()<CR>
noremap <silent> <Leader>qpm :call ToggleManProg()<CR>
noremap <Leader>qpM :set makeprg=make<CR>

" v in front of variables that have names similar to settings they control

" Simple settings with variables
let g:buffmt = 1
let g:bufcomp = 0
autocmd FileType * let b:buffmt = g:buffmt
autocmd FileType * let b:bufcomp = g:bufcomp

noremap <Leader>qff :let b:buffmt=!b:buffmt<CR>
noremap <Leader>qfF :let g:buffmt=!g:buffmt<CR>
noremap <Leader>qv1 :echo b:buffmt<CR>

noremap <Leader>qfc :let b:bufcomp=!b:bufcomp<CR>
noremap <Leader>qfC :let g:bufcomp=!g:bufcomp<CR>
noremap <Leader>qv2 :echo b:bufcomp<CR>

" Nontrivial settings
let g:vautoread = 0
let g:vautowrite = 0
autocmd FileType * let b:vautoread = g:vautoread
autocmd FileType * let b:vautowrite = g:vautowrite

noremap <Leader>qfr :call ToggleBuffer('autoread')<CR>
noremap <Leader>qfR :let g:vautoread=!g:vautoread<CR>
noremap <Leader>qv3 :echo b:vautoread<CR>

noremap <Leader>qfw :call ToggleBuffer('autowrite')<CR>
noremap <Leader>qfW :let g:vautowrite=!g:vautowrite<CR>
noremap <Leader>qv4 :echo b:vautowrite<CR>

set cursorline
noremap <Leader>qec :set cursorline!<CR>

let g:autochdir = 0
" autocmd BufNewFile * let b:autochdir = g:autochdir
noremap <Leader>qca :call ToggleAutochdir()<CR>
" noremap <Leader>qcA :let g:autochdir=!g:autochdir<CR>

" TODO
" let g:autoupdate = 0
" autocmd FileType * let b:autoupdate = g:autoupdate

" noremap <Leader>qfu :call ToggleAutoupdate()<CR>
" noremap <Leader>qfU :let g:autoupdate=!g:autoupdate<CR>
" noremap <Leader>qv5 :echo b:autoupdate<CR>
