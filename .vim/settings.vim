" {{{ heavy stuff

" ??
set path+=**
" set path+=../**

let mapleader = ','
" TODO C how the fuck to do that well
let maplocalleader = '\'

autocmd FileType * let b:match_ignorecase = 0
let g:pathshorten = 4

let g:no_file_msg = 1
autocmd WinNew,VimEnter *
      \ let w:prev_dir = expand('%:p:h')
      \ | let g:no_file_msg = 0
      \ | echo expand('%:p')

" arglocal with current file for all new tabs
autocmd TabNew *
      \ let t:make_list = get(t:, 'make_list', 1)

" TODO A is this better with checking if exists
" Has to use this because of order of events
autocmd BufEnter *
      \ if get(t:, 'make_list', 0)
      \ |   if expand('%') == ''
      \ |     arglocal!
      \ |     for _ in range(argc())
      \ |       argdelete
      \ |     endfor
      \ |   else
      \ |     exe 'arglocal! %'
      \ |   endif
      \ | endif
      \ | let t:make_list = 0

" set secure
" shitty, but works somehow
autocmd BufReadPost *
      \ if (&buftype == "") && (&filetype == "")
      \ |     filetype detect
      \ | endif
      \ | if (&buftype == "") && (&ft == "")
      \ |     if getline(1) =~ "^!"
      \ |         set filetype=xmodmap
      \ |     else
      \ |         setlocal secure modeline
      \ |         e
      \ |     endif
      \ | endif

set foldmethod=marker

set shell=sh

" }}}

"{{{ good looking

set splitkeep=screen

set termguicolors

set shortmess=atsOF
" 2 is ugly and takes too much space
" but would make life easier sometimes
set cmdheight=1
set laststatus=0

" TODO C tabline

set statusline+=%<
set statusline+=%f
set statusline+=\ 
set statusline+=%h
set statusline+=%m
set statusline+=%r
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)
set statusline+=\ 
set statusline+=%P

"}}}

" {{{ some simple toggling

nnoremap <Leader><Space><Space> :<C-u>setlocal hls!<CR>
vnoremap <Leader><Space><Space> :<C-u>setlocal hls!\|norm gv<CR>
nnoremap <Leader>qen :<C-u>set relativenumber!<CR>
vnoremap <Leader>qen :<C-u>set relativenumber!\|norm gv<CR>
nnoremap <Leader>qeN :<C-u>set number!<CR>
vnoremap <Leader>qeN :<C-u>set number!\|norm gv<CR>
nnoremap <Leader>qeC :<C-u>set cursorbind!<CR>
vnoremap <Leader>qeC :<C-u>set cursorbind!\|norm gv<CR>
nnoremap <Leader>qep :<C-u>set paste!<CR>
vnoremap <Leader>qep :<C-u>set paste!\|norm gv<CR>

set cursorline

nnoremap <Leader>qec :<C-u>set cursorline!<CR>
vnoremap <Leader>qec :<C-u>set cursorline!\|norm gv<CR>

nnoremap <Leader>qkw :<C-u>call Wmt()<CR>
vnoremap <Leader>qkw :<C-u>call Wmt()\|norm gv<CR>
nnoremap <silent> <Leader>qpm :<C-u>call ToggleManProg()<CR>
vnoremap <silent> <Leader>qpm :<C-u>call ToggleManProg()\|norm gv<CR>
nnoremap <Leader>qpM :<C-u>set makeprg=make<CR>
vnoremap <Leader>qpM :<C-u>set makeprg=make\|norm gv<CR>

nnoremap <Leader>qet :<C-u>filetype detect<CR>
vnoremap <Leader>qet :<C-u>filetype detect\|norm gv<CR>
nnoremap <Leader>qeT :<C-u>set filetype=
vnoremap <Leader>qeT 
      \ :<C-u>set filetype= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Leader>qeh :<C-u>set hls!<CR>
vnoremap <Leader>qeh :<C-u>set hls!\|norm gv<CR>

" }}}

"{{{ automatic formatting and compiling control

let g:buffmt = 1
let g:bufcomp = 0
autocmd FileType * let b:buffmt = g:buffmt
autocmd FileType * let b:bufcomp = g:bufcomp

nnoremap <Leader>qff :<C-u>let b:buffmt=!b:buffmt<CR>
vnoremap <Leader>qff :<C-u>let b:buffmt=!b:buffmt\|norm gv<CR>
nnoremap <Leader>qfF :<C-u>let g:buffmt=!g:buffmt<CR>
vnoremap <Leader>qfF :<C-u>let g:buffmt=!g:buffmt\|norm gv<CR>
nnoremap <Leader>qv1 :<C-u>echo b:buffmt<CR>
vnoremap <Leader>qv1 :<C-u>echo b:buffmt\|norm gv<CR>

nnoremap <Leader>qfc :<C-u>let b:bufcomp=!b:bufcomp<CR>
vnoremap <Leader>qfc :<C-u>let b:bufcomp=!b:bufcomp\|norm gv<CR>
nnoremap <Leader>qfC :<C-u>let g:bufcomp=!g:bufcomp<CR>
vnoremap <Leader>qfC :<C-u>let g:bufcomp=!g:bufcomp\|norm gv<CR>
nnoremap <Leader>qv2 :<C-u>echo b:bufcomp<CR>
vnoremap <Leader>qv2 :<C-u>echo b:bufcomp\|norm gv<CR>

"}}}

" {{{ nontrivial settings

autocmd BufRead * let b:vautowrite = g:vautowrite

" v in front of variables that have names similar to settings they control
let g:vautoread = 0
let g:vautowrite = 0
autocmd FileType * let b:vautoread = g:vautoread
autocmd FileType * let b:vautowrite = g:vautowrite

nnoremap <Leader>qfr :<C-u>call ToggleBuffer('autoread')<CR>
vnoremap <Leader>qfr :<C-u>call ToggleBuffer('autoread')\|norm gv<CR>
nnoremap <Leader>qfR :<C-u>let g:vautoread=!g:vautoread<CR>
vnoremap <Leader>qfR :<C-u>let g:vautoread=!g:vautoread\|norm gv<CR>
nnoremap <Leader>qv3 :<C-u>echo b:vautoread<CR>
vnoremap <Leader>qv3 :<C-u>echo b:vautoread\|norm gv<CR>

nnoremap <Leader>qfw :<C-u>call ToggleBuffer('autowrite')<CR>
vnoremap <Leader>qfw :<C-u>call ToggleBuffer('autowrite')\|norm gv<CR>
nnoremap <Leader>qfW :<C-u>let g:vautowrite=!g:vautowrite<CR>
vnoremap <Leader>qfW :<C-u>let g:vautowrite=!g:vautowrite\|norm gv<CR>
nnoremap <Leader>qv4 :<C-u>echo b:vautowrite<CR>
vnoremap <Leader>qv4 :<C-u>echo b:vautowrite\|norm gv<CR>

" TODO
" let g:autoupdate = 0
" autocmd FileType * let b:autoupdate = g:autoupdate

" noremap <Leader>qfu :call ToggleAutoupdate()<CR>
" noremap <Leader>qfU :let g:autoupdate=!g:autoupdate<CR>
" noremap <Leader>qv5 :echo b:autoupdate<CR>

" }}}

"{{{ completion

set omnifunc=syntaxcomplete#Complete

"}}}

" {{{ other

" Closing loclist when closing parent window
if exists('##QuitPre')
    autocmd QuitPre * nested if &filetype != 'qf' | silent! lclose | endif
endif

" default updatetime 4000ms is not good for async update
set updatetime=50

let g:autochdir = 0
let w:prev_dir = expand('%:p:h')
silent call ToggleAutochdir()

nnoremap <Leader>qca :<C-u>call ToggleAutochdir()<CR>
vnoremap <Leader>qca :<C-u>call ToggleAutochdir()\|norm gv<CR>

" }}}
