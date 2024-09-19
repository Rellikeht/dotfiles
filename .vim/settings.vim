" {{{ heavy stuff

" slightly slower than
" set shell=sh
" but acceptable
set shell=bash

set noshelltemp

let mapleader = ','
" TODO C how the fuck to do that well
let maplocalleader = '\'

autocmd FileType * let b:match_ignorecase = 0
let g:pathshorten = 4

let g:no_file_msg = 0
autocmd VimEnter *
      \ let w:buf_echo = 0

autocmd WinNew *
      \ let g:prev_dir = expand('%:p:h')
      \ | let w:buf_echo = 1
      \ | let w:prev_arg = 0

autocmd BufWinEnter *
      \ if get(w:, 'buf_echo', 0)
      \ | let w:buf_echo = 0
      \ | if &buftype == '' && !get(g:, 'no_file_msg', 1)
      \ | echo expand('%:p')
      \ | endif
      \ | endif

" arglocal with current file for all new tabs
" autocmd TabNew * arglocal!

" set secure

" modeline for undetected filetypes
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
set foldmarker=\ {{{,\ }}}
set synmaxcol=250

" }}}

" {{{ wildignore

set wildignore+=.git/**
set wildignore+=.local/**
set wildignore+=.\?cache/**
set wildignore+=git*/**
set wildignore+=build/**

set wildignore+=*.o,*.obj,*.swp
set wildignore+=*.so,*.a,*.bin
set wildignore+=*.pdf,*.djvu,*.epub
set wildignore+=*.opus,*.ogg,*.mp3
set wildignore+=*.mp4,*.mkv,*.webm
set wildignore+=*.AppImage
set wildignore+=*.lock,*~
set wildignore+=*.doc,*.xls
set wildignore+=.\?git*
" set wildignore+=*/

" }}}

" {{{ good looking

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

set scrolloff=4

" }}}

" {{{ some simple toggling

noremap <Leader>q <Nop>

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

" nnoremap <Leader>qpM :<C-u>set makeprg=make<CR>
" vnoremap <Leader>qpM :<C-u>set makeprg=make\|norm gv<CR>

nnoremap <Leader>qet :<C-u>filetype detect<CR>
vnoremap <Leader>qet :<C-u>filetype detect\|norm gv<CR>
nnoremap <Leader>qeT :<C-u>set filetype=
vnoremap <Leader>qeT 
      \ :<C-u>set filetype= \|norm gv
      \ <C-Left><C-Left><Left>
nnoremap <Leader>qeh :<C-u>set hls!<CR>
vnoremap <Leader>qeh :<C-u>set hls!\|norm gv<CR>

" }}}

" {{{ automatic formatting and compiling control

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

" }}}

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

" TODO C
let g:autoupdate = 0
" autocmd FileType * let b:autoupdate = g:autoupdate

" noremap <Leader>qfu :call ToggleAutoupdate()<CR>
" noremap <Leader>qfU :let g:autoupdate=!g:autoupdate<CR>
" noremap <Leader>qv5 :echo b:autoupdate<CR>

" }}}

" {{{ completion

set omnifunc=syntaxcomplete#Complete
set pumwidth=15
set pumheight=20

" }}}

" This doesn't help, but why not keep it
augroup LargeFile " {{{

  " 20 MB
  let g:large_file = 20971520

  " Set options:
  "   eventignore+=FileType (no syntax highlighting etc
  "   assumes FileType always on)
  "   noswapfile (save copy of file)
  "   bufhidden=unload (save memory when other file is viewed)
  "   buftype=nowritefile (is read-only)
  "   undolevels=-1 (no undo possible)
  au BufReadPre *
        \ let f=expand("<afile>") |
        \ if getfsize(f) > g:large_file |
        \ syntax off |
        \ setlocal eventignore+=FileType |
        \ setlocal bufhidden=unload buftype=nowrite undolevels=-1 |
        \ setlocal noswapfile noundofile noloadplugins wrap |
        \ setlocal nocursorline |
        \ else |
        \ setlocal eventignore-=FileType |
        \ endif

augroup END " }}}

" {{{ other

set breakindentopt=shift:2,min:40,sbr

" Closing loclist when closing parent window
if exists('##QuitPre')
  autocmd QuitPre * nested if &filetype != 'qf' | silent! lclose | endif
endif

" default updatetime 4000ms is not good for async update
set updatetime=50

let g:prev_dir = expand('%:p:h')
let g:autochdir = 0
autocmd VimEnter * 
      \ silent call ToggleAutochdir()
      \ | exe 'lcd %:p:h'

nnoremap <Leader>qca :<C-u>call ToggleAutochdir()<CR>
vnoremap <Leader>qca :<C-u>call ToggleAutochdir()\|norm gv<CR>

" }}}

" {{{ grep

let g:grep = 'grep -EI --exclude-dir=.git'.
      \ ' --exclude-dir=.hg'.
      \ ' --exclude-dir=build'.
      \ ' --exclude-dir=?cache'
let g:vimgrep = g:grep.' -Hn'

" }}}
