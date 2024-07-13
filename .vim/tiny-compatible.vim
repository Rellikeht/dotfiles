" {{{ basic mappings

" Because <C-w> is uncomfortable to press
map ; <C-w>
map ;; <C-w><C-w>

" Has to be that way
" <CR> is equal to <C-m> !!
noremap <C-m> <Tab>

" TODO make this work
noremap gy "*y
noremap gY "+y
" noremap gy "*gP
" noremap gY "+gP

" TODO this is harder than it should be
noremap g+ v<C-a>
noremap g- v<C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" }}}

"{{{ settings with <Space>

nnoremap <Space>qw :<C-u>set wrap!<CR>
vnoremap <Space>qw :<C-u>set wrap!\|norm gv<CR>
nnoremap <Space>qs :<C-u>source %<CR>
vnoremap <Space>qs :<C-u>source %\|norm gv<CR>
nnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e<CR>
vnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e\|norm gv<CR>
nnoremap <Space>qM :<C-u>setlocal modeline!<CR>
vnoremap <Space>qM :<C-u>setlocal modeline!\|norm gv<CR>

"}}}

" TODO D more and better visual mappings

" {{{ tabs with <Tab>

noremap <Tab>o :<C-u>tabedit<Space>
noremap <Tab>O :<C-u>-tabedit<Space>
noremap <Tab><Tab> :<C-u>tab<Space>
noremap <Tab>; :<C-u>-tab<Space>

noremap <Tab>a :<C-u>tabnew\|arglocal!<Space>
noremap <Tab>A :<C-u>tabnew\|arglocal!<CR>

nnoremap <Tab>l :<C-u>tabs<CR>
vnoremap <Tab>l :<C-u>tabs\|norm gv<CR>
" v map doesn't work
noremap <Tab><Space>l :filter  tabs<C-Left><Left>

nnoremap <silent> <Tab>! :<C-u>tabonly<CR>
vnoremap <silent> <Tab>! :<C-u>tabonly\|norm gv<CR>

noremap <Tab>b :<C-u>tab<Space>sb<Space>
noremap <Tab>B :<C-u>-tab<Space>sb<Space>

noremap <silent> <Tab>0 :<C-u>tabfirst<CR>
noremap <silent> <Tab>$ :<C-u>tablast<CR>
noremap <Tab>n gt
noremap <Tab>p gT

nnoremap <Tab>m :<C-u>tabm<Space>
vnoremap <Tab>m :<C-u>tabm\|norm gv<Space>
nnoremap <silent> <Tab>N :<C-u>tabm +1<CR>
vnoremap <silent> <Tab>N :<C-u>tabm +1\|norm gv<CR>
nnoremap <silent> <Tab>P :<C-u>tabm -1<CR>
vnoremap <silent> <Tab>P :<C-u>tabm -1\|norm gv<CR>
nnoremap <silent> <Tab>J :<C-u>tabm $<CR>
vnoremap <silent> <Tab>J :<C-u>tabm $\|norm gv<CR>
nnoremap <silent> <Tab>K :<C-u>tabm 0<CR>
vnoremap <silent> <Tab>K :<C-u>tabm 0\|norm gv<CR>

nnoremap <Tab>t :<C-u>tabdo<Space>
vnoremap <Tab>t :<C-u>tabdo\|norm gv<Space>

" }}}

" {{{ splits with <Tab>

noremap <Tab>v :<C-u>vsplit<Space>
noremap <silent> <Tab>V :<C-u>vsplit<CR>
noremap <Tab>s :<C-u>split<Space>
noremap <silent> <Tab>S :<C-u>split<CR>
noremap <Tab>u :<C-u>botright split<Space>
noremap <silent> <Tab>U :<C-u>botright split<CR>
noremap <Tab>g :<C-u>botright vsplit<Space>
noremap <silent> <Tab>G :<C-u>botright vsplit<CR>

" }}}

" {{{ resizing with <Tab>
" TODO better
" TODO more

nnoremap <silent> <Tab>>1 :<C-u>vertical resize 10<CR>
vnoremap <silent> <Tab>>1 :<C-u>vertical resize 10\|norm gv<CR>
nnoremap <silent> <Tab>>2 :<C-u>vertical resize 20<CR>
vnoremap <silent> <Tab>>2 :<C-u>vertical resize 20\|norm gv<CR>
nnoremap <silent> <Tab>>3 :<C-u>vertical resize 30<CR>
vnoremap <silent> <Tab>>3 :<C-u>vertical resize 30\|norm gv<CR>
nnoremap <silent> <Tab>>4 :<C-u>vertical resize 40<CR>
vnoremap <silent> <Tab>>4 :<C-u>vertical resize 40\|norm gv<CR>
nnoremap <silent> <Tab>>5 :<C-u>vertical resize 50<CR>
vnoremap <silent> <Tab>>5 :<C-u>vertical resize 50\|norm gv<CR>
noremap <Tab>>r :<C-u>vertical resize <Space>

nnoremap <silent> <Tab>>= :<C-u>vertical resize +1<CR>
vnoremap <silent> <Tab>>= :<C-u>vertical resize +1\|norm gv<CR>
nnoremap <silent> <Tab>>+ :<C-u>vertical resize +5<CR>
vnoremap <silent> <Tab>>+ :<C-u>vertical resize +5\|norm gv<CR>
nnoremap <silent> <Tab>>a :<C-u>vertical resize +10<CR>
vnoremap <silent> <Tab>>a :<C-u>vertical resize +10\|norm gv<CR>
nnoremap <silent> <Tab>>A :<C-u>vertical resize +20<CR>
vnoremap <silent> <Tab>>A :<C-u>vertical resize +20\|norm gv<CR>
nnoremap <silent> <Tab>>- :<C-u>vertical resize -1<CR>
vnoremap <silent> <Tab>>- :<C-u>vertical resize -1\|norm gv<CR>
nnoremap <silent> <Tab>>_ :<C-u>vertical resize -5<CR>
vnoremap <silent> <Tab>>_ :<C-u>vertical resize -5\|norm gv<CR>
nnoremap <silent> <Tab>>d :<C-u>vertical resize -10<CR>
vnoremap <silent> <Tab>>d :<C-u>vertical resize -10\|norm gv<CR>
nnoremap <silent> <Tab>>D :<C-u>vertical resize -20<CR>
vnoremap <silent> <Tab>>D :<C-u>vertical resize -20\|norm gv<CR>

nnoremap <silent> <Tab>^1 :<C-u>resize 10<CR>
vnoremap <silent> <Tab>^1 :<C-u>resize 10\|norm gv<CR>
nnoremap <silent> <Tab>^2 :<C-u>resize 20<CR>
vnoremap <silent> <Tab>^2 :<C-u>resize 20\|norm gv<CR>
nnoremap <silent> <Tab>^3 :<C-u>resize 30<CR>
vnoremap <silent> <Tab>^3 :<C-u>resize 30\|norm gv<CR>
nnoremap <silent> <Tab>^4 :<C-u>resize 40<CR>
vnoremap <silent> <Tab>^4 :<C-u>resize 40\|norm gv<CR>
nnoremap <silent> <Tab>^5 :<C-u>resize 50<CR>
vnoremap <silent> <Tab>^5 :<C-u>resize 50\|norm gv<CR>
noremap <silent> <Tab>^r :<C-u>resize <Space>

nnoremap <silent> <Tab>^= :<C-u>resize +1<CR>
vnoremap <silent> <Tab>^= :<C-u>resize +1\|norm gv<CR>
nnoremap <silent> <Tab>^+ :<C-u>resize +5<CR>
vnoremap <silent> <Tab>^+ :<C-u>resize +5\|norm gv<CR>
nnoremap <silent> <Tab>^a :<C-u>resize +10<CR>
vnoremap <silent> <Tab>^a :<C-u>resize +10\|norm gv<CR>
nnoremap <silent> <Tab>^A :<C-u>resize +20<CR>
vnoremap <silent> <Tab>^A :<C-u>resize +20\|norm gv<CR>
nnoremap <silent> <Tab>^- :<C-u>resize -1<CR>
vnoremap <silent> <Tab>^- :<C-u>resize -1\|norm gv<CR>
nnoremap <silent> <Tab>^_ :<C-u>resize -5<CR>
vnoremap <silent> <Tab>^_ :<C-u>resize -5\|norm gv<CR>
nnoremap <silent> <Tab>^d :<C-u>resize -10<CR>
vnoremap <silent> <Tab>^d :<C-u>resize -10\|norm gv<CR>
nnoremap <silent> <Tab>^D :<C-u>resize -20<CR>
vnoremap <silent> <Tab>^D :<C-u>resize -20\|norm gv<CR>

" }}}

" {{{ buffers with <Space><Space>

noremap <Space><Space>o :<C-u>buffer<Space>
noremap <Space><Space>O :<C-u>buffer!<Space>

nnoremap <Space><Space>l :<C-u>buffers<CR>
vnoremap <Space><Space>l :<C-u>buffers\|norm gv<CR>
noremap <Space><Space>;l :<C-u>filter  buffers<C-Left><C-b>
noremap <Space><Space>;L :<C-u>filter  buffers!<C-Left><C-b>

noremap <silent> <Space><Space>n :<C-u>bnext<CR>
noremap <silent> <Space><Space>p :<C-u>bprevious<CR>
noremap <silent> <Space><Space>N :<C-u>bnext!<CR>
noremap <silent> <Space><Space>P :<C-u>bprevious!<CR>
noremap <silent> <Space><Space>m :<C-u>bmodified<CR>
noremap <silent> <Space><Space>M :<C-u>bmodified!<CR>

noremap <silent> <Space><Space>d :<C-u>bdelete<CR>
noremap <silent> <Space><Space>D :<C-u>bdelete!<CR>
noremap <silent> <Space><Space>u :<C-u>bunload<CR>
noremap <silent> <Space><Space>U :<C-u>bunload!<CR>
noremap <silent> <Space><Space>w :<C-u>bwipeout<CR>
noremap <silent> <Space><Space>W :<C-u>bwipeout!<CR>

noremap <Space><Space>;n :<C-u>bnext<Space>
noremap <Space><Space>;p :<C-u>bprevious<Space>
noremap <Space><Space>;N :<C-u>bnext!<Space>
noremap <Space><Space>;P :<C-u>bprevious!<Space>
noremap <Space><Space>;m :<C-u>bmodified<Space>
noremap <Space><Space>;M :<C-u>bmodified!<Space>

noremap <Space><Space>;d :<C-u>bdelete<Space>
noremap <Space><Space>;D :<C-u>bdelete!<Space>
noremap <Space><Space>;u :<C-u>bunload<Space>
noremap <Space><Space>;U :<C-u>bunload!<Space>
noremap <Space><Space>;w :<C-u>bwipeout<Space>
noremap <Space><Space>;W :<C-u>bwipeout!<Space>

nnoremap <Space><Space>A :<C-u>balt<Space>
vnoremap <Space><Space>A :<C-u>balt  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>a :<C-u>badd<Space>
vnoremap <Space><Space>a :<C-u>badd  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>t :<C-u>bufdo<Space>
vnoremap <Space><Space>t :<C-u>bufdo<Space> \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>T :<C-u>bufdo!<Space>
vnoremap <Space><Space>T :<C-u>bufdo!  \|norm gv<C-Left><C-Left><Left>

" }}}

"{{{ args with <Space>

nnoremap <Space>l :<C-u>args<CR>
vnoremap <Space>l :<C-u>args\|norm gv<CR>
noremap <Space>;l :<C-u>filter  args<C-Left><C-b>

noremap <Space>e :<C-u>argument<Space>
noremap <Space>E :<C-u>argument!<Space>
noremap <Space>o :<C-u>argedit<Space>
noremap <Space>O :<C-u>argedit!<Space>
nnoremap <Space>a :<C-u>argadd<Space>
vnoremap <Space>a :<C-u>argadd  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>d :<C-u>argdelete<Space>
vnoremap <Space>d :<C-u>argdelete  \|norm gv<C-Left><C-Left><Left>

noremap <silent> <Space>n :<C-u>next<CR>
noremap <silent> <Space>N :<C-u>next!<CR>
noremap <Space><Space>n :<C-u>next<Space>
noremap <Space><Space>N :<C-u>next!<Space>
noremap <silent> <Space>p :<C-u>previous<CR>
noremap <silent> <Space>P :<C-u>previous!<CR>
noremap <Space><Space>p :<C-u>previous<Space>
noremap <Space><Space>P :<C-u>previous!<Space>

noremap <silent> <Space>. :<C-u>wnext<CR>
noremap <silent> <Space>> :<C-u>wnext!<CR>
noremap <Space><Space>. :<C-u>wnext<Space>
noremap <Space><Space>> :<C-u>wnext!<Space>
noremap <silent> <Space>, :<C-u>wprevious<CR>
noremap <silent> <Space>< :<C-u>wprevious!<CR>
noremap <Space><Space>, :<C-u>wprevious<Space>
noremap <Space><Space>< :<C-u>wprevious!<Space>

noremap <silent> <Space>0 :<C-u>first<CR>
noremap <silent> <Space>0 :<C-u>first!<CR>
noremap <Space><Space>0 :<C-u>first<Space>
noremap <Space><Space>0 :<C-u>first!<Space>
noremap <silent> <Space>$ :<C-u>last<CR>
noremap <silent> <Space>$ :<C-u>last!<CR>
noremap <Space><Space>$ :<C-u>last<Space>
noremap <Space><Space>$ :<C-u>last!<Space>

noremap <Space>= :<C-u>args!<Space>
noremap <Space>_ :<C-u>argdedupe<CR>
noremap <Space>t :<C-u>argdo<Space>
noremap <Space>T :<C-u>argdo!<Space>

nnoremap <silent> <Space>w :<C-u>arglocal<CR>
vnoremap <silent> <Space>w :<C-u>arglocal\|norm gv<CR>
nnoremap <silent> <Space>W :<C-u>arglocal!<CR>
vnoremap <silent> <Space>W :<C-u>arglocal!\|norm gv<CR>
noremap <Space><Space>w :<C-u>arglocal<Space>
noremap <Space><Space>W :<C-u>arglocal!<Space>
nnoremap <silent> <Space>g :<C-u>argglobal<CR>
vnoremap <silent> <Space>g :<C-u>argglobal\|norm gv<CR>
nnoremap <silent> <Space>G :<C-u>argglobal!<CR>
vnoremap <silent> <Space>G :<C-u>argglobal!\|norm gv<CR>
noremap <Space><Space>g :<C-u>argglobal<Space>
noremap <Space><Space>G :<C-u>argglobal!<Space>

"}}}

" {{{ <Space> list and help

nnoremap <Space>ir :<C-u>registers<CR>
vnoremap <Space>ir :<C-u>registers\|norm gv<CR>
nnoremap <Space>ip :<C-u>history<CR>
vnoremap <Space>ip :<C-u>history\|norm gv<CR>
nnoremap <Space>ic :<C-u>changes<CR>
vnoremap <Space>ic :<C-u>changes\|norm gv<CR>
nnoremap <Space>ij :<C-u>jumps<CR>
vnoremap <Space>ij :<C-u>jumps\|norm gv<CR>
nnoremap <Space>io :<C-u>files<CR>
vnoremap <Space>io :<C-u>files\|norm gv<CR>
nnoremap <Space>it :<C-u>tags<CR>
vnoremap <Space>it :<C-u>tags\|norm gv<CR>
nnoremap <Space>im :<C-u>marks<CR>
vnoremap <Space>im :<C-u>marks\|norm gv<CR>
nnoremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
vnoremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ\|norm gv<CR>

noremap <Space>i<Space>r
           \ :<C-u>filter  registers<C-Left><Left>
noremap <Space>i<Space>p
           \ :<C-u>filter  history<C-Left><Left>
noremap <Space>i<Space>c
           \ :<C-u>filter  changes<C-Left><Left>
noremap <Space>i<Space>j
           \ :<C-u>filter  jumps<C-Left><Left>
noremap <Space>i<Space>o
           \ :<C-u>filter  files<C-Left><Left>
noremap <Space>i<Space>t
           \ :<C-u>filter  tags<C-Left><Left>
noremap <Space>i<Space>m
           \ :<C-u>filter  marks<C-Left><Left>

noremap <Space>ik :<C-u>map<Space>
noremap <Space>in :<C-u>nmap<Space>
noremap <Space>iv :<C-u>vmap<Space>
noremap <Space>ii :<C-u>imap<Space>

noremap <Space>ih :<C-u>help<Space>
noremap <Space>i<Tab> :<C-u>tab help<Space>

" retarded 'more' kicks in
noremap <Space>m :<C-u>marks<CR>:normal `

" }}}

" {{{ other mappings

" Select whole buffer without plugins
vnoremap ae <Esc>gg0vG$
" Not exact vie
vnoremap ie <Esc>gg}{vG{}k$
nnoremap yae mcggvG$y`c

" }}}

" {{{ settings

" {{{ completion

" What happens here
set wildchar=<Tab>
set wildmode=list:longest,full
set wildoptions=fuzzy,tagfile,pum
set wildmenu

set completeopt=menu,menuone,noselect,noinsert,preview
set complete=w,b,s,i,d,t,.,k

" }}}

" {{{ display

set noterse
set ruler
set number
set relativenumber

set showcmd
set showmatch
set nohlsearch

" }}}

" {{{ search

set incsearch
set ignorecase
set smartcase

" }}}

" {{{ indent

set autoindent
set cindent
set expandtab
set shiftwidth=4
set tabstop=4
set breakindent

" }}}

" {{{ ui

set linebreak

set nowrap
set showbreak=\\>\ 

set notimeout
set ttimeout
set ttimeoutlen=100
set mouse=a

" Not really needed
" set clipboard=unnamed

" }}}

"{{{ editing

set formatoptions=tcroqlwn

" Neovim default setting at time of writing this
set backspace=indent,eol,start

"}}}

" {{{ other

set noautochdir
set autoread

set termencoding=utf-8
set encoding=utf-8

set modelines=3
set nomodeline
set hidden

" }}}

" }}}

if v:progname =~? "^tv\\(im\\?\\)\\?" " {{{ 
    set background=dark
    set hlsearch
    noremap <Tab><Space> :setlocal hls!<CR>
    noremap <Tab>qh :set hls!<CR>
endif
" }}}
