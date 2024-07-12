" {{{ basic mappings

" Because <C-w> is uncomfortable to press
map ; <C-w>
map ;; <C-w><C-w>

" Has to be that way
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

nnoremap <Space>qw :set wrap!<CR>
nnoremap <Space>qs :source %<CR>
nnoremap <Space>qm :setlocal modeline!<CR>:e<CR>
nnoremap <Space>qM :setlocal modeline!<CR>

"}}}

" TODO C visual mappings

" {{{ tabs with <Tab>

noremap <Tab>o :<C-u>tabedit<Space>
noremap <Tab>O :<C-u>-tabedit<Space>
noremap <Tab><Tab> :<C-u>tab<Space>
noremap <Tab>; :<C-u>-tab<Space>

noremap <Tab>a :<C-u>tabnew\|arglocal!<Space>
noremap <Tab>A :<C-u>tabnew\|arglocal!<CR>

noremap <Tab>l :<C-u>tabs<CR>
nnoremap <Tab><Space>l :filter  tabs<C-Left><C-b>
" nnoremap <Tab><Space>L :filter!  tabs<C-Left><C-b>

noremap <silent> <Tab>+ :<C-u>tabnew<CR>
noremap <silent> <Tab>- :<C-u>tabclose<CR>
noremap <silent> <Tab>! :<C-u>tabonly<CR>

noremap <Tab>b :<C-u>tab<Space>sb<Space>
noremap <Tab>B :<C-u>-tab<Space>sb<Space>

noremap <silent> <Tab>0 :<C-u>tabfirst<CR>
noremap <silent> <Tab>$ :<C-u>tablast<CR>
noremap <Tab>n gt
noremap <Tab>p gT

noremap <Tab>m :<C-u>tabm<Space>
noremap <silent> <Tab>N :<C-u>tabm +1<CR>
noremap <silent> <Tab>P :<C-u>tabm -1<CR>
noremap <silent> <Tab>J :<C-u>tabm $<CR>
noremap <silent> <Tab>K :<C-u>tabm 0<CR>

noremap <Tab>t :<C-u>tabdo<Space>

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

noremap <silent> <Tab>>1 :<C-u>vertical resize 10<CR>
noremap <silent> <Tab>>2 :<C-u>vertical resize 20<CR>
noremap <silent> <Tab>>3 :<C-u>vertical resize 30<CR>
noremap <silent> <Tab>>4 :<C-u>vertical resize 40<CR>
noremap <silent> <Tab>>5 :<C-u>vertical resize 50<CR>
noremap <Tab>>r :<C-u>vertical resize <Space>

noremap <silent> <Tab>>= :<C-u>vertical resize +1<CR>
noremap <silent> <Tab>>+ :<C-u>vertical resize +5<CR>
noremap <silent> <Tab>>a :<C-u>vertical resize +10<CR>
noremap <silent> <Tab>>A :<C-u>vertical resize +20<CR>
noremap <silent> <Tab>>- :<C-u>vertical resize -1<CR>
noremap <silent> <Tab>>_ :<C-u>vertical resize -5<CR>
noremap <silent> <Tab>>d :<C-u>vertical resize -10<CR>
noremap <silent> <Tab>>D :<C-u>vertical resize -20<CR>

noremap <silent> <Tab>^1 :<C-u>resize 10<CR>
noremap <silent> <Tab>^2 :<C-u>resize 20<CR>
noremap <silent> <Tab>^3 :<C-u>resize 30<CR>
noremap <silent> <Tab>^4 :<C-u>resize 40<CR>
noremap <silent> <Tab>^5 :<C-u>resize 50<CR>
noremap <silent> <Tab>^r :<C-u>resize <Space>

noremap <silent> <Tab>^= :<C-u>resize +1<CR>
noremap <silent> <Tab>^+ :<C-u>resize +5<CR>
noremap <silent> <Tab>^a :<C-u>resize +10<CR>
noremap <silent> <Tab>^A :<C-u>resize +20<CR>
noremap <silent> <Tab>^- :<C-u>resize -1<CR>
noremap <silent> <Tab>^_ :<C-u>resize -5<CR>
noremap <silent> <Tab>^d :<C-u>resize -10<CR>
noremap <silent> <Tab>^D :<C-u>resize -20<CR>

" }}}

" {{{ buffers with <Space><Space>

noremap <Space><Space>o :<C-u>buffer<Space>
noremap <Space><Space>O :<C-u>buffer!<Space>

noremap <Space><Space>l :<C-u>buffers<CR>
nnoremap <Space><Space>;l :<C-u>filter  buffers<C-Left><C-b>
nnoremap <Space><Space>;L :<C-u>filter  buffers!<C-Left><C-b>

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

noremap <Space><Space>a :<C-u>badd<Space>
noremap <Space><Space>A :<C-u>balt<Space>
noremap <Space><Space>t :<C-u>bufdo<Space>
noremap <Space><Space>T :<C-u>bufdo!<Space>

" }}}

"{{{ args with <Space>

noremap <Space>l :<C-u>args<CR>
nnoremap <Space>;l :<C-u>filter  args<C-Left><C-b>

noremap <Space>e :<C-u>argument<Space>
noremap <Space>E :<C-u>argument!<Space>
noremap <Space>o :<C-u>argedit<Space>
noremap <Space>O :<C-u>argedit!<Space>
noremap <Space>a :<C-u>argadd<Space>
noremap <Space>d :<C-u>argdelete<Space>

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

noremap <silent> <Space>w :<C-u>arglocal<CR>
noremap <silent> <Space>W :<C-u>arglocal!<CR>
noremap <Space><Space>w :<C-u>arglocal<Space>
noremap <Space><Space>W :<C-u>arglocal!<Space>
noremap <silent> <Space>g :<C-u>argglobal<CR>
noremap <silent> <Space>G :<C-u>argglobal!<CR>
noremap <Space><Space>g :<C-u>argglobal<Space>
noremap <Space><Space>G :<C-u>argglobal!<Space>

"}}}

" {{{ <Space> list and help

noremap <Space>ir :<C-u>registers<CR>
noremap <Space>ip :<C-u>history<CR>
noremap <Space>ic :<C-u>changes<CR>
noremap <Space>ij :<C-u>jumps<CR>
noremap <Space>io :<C-u>files<CR>
noremap <Space>im :<C-u>marks<CR>
noremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>

nnoremap <Space>i<Space>r 
            \ :<C-u>filter  registers<C-Left><C-b>
nnoremap <Space>i<Space>p 
            \ :<C-u>filter  history<C-Left><C-b>
nnoremap <Space>i<Space>c 
            \ :<C-u>filter  changes<C-Left><C-b>
nnoremap <Space>i<Space>j 
            \ :<C-u>filter  jumps<C-Left><C-b>
nnoremap <Space>i<Space>o 
            \ :<C-u>filter  files<C-Left><C-b>
nnoremap <Space>i<Space>m 
            \ :<C-u>filter  marks<C-Left><C-b>

noremap <Space>ik :<C-u>map<Space>
noremap <Space>in :<C-u>nmap<Space>
noremap <Space>iv :<C-u>vmap<Space>
noremap <Space>ii :<C-u>imap<Space>

noremap <Space>ih :<C-u>help<Space>
noremap <Space>it :<C-u>tab help<Space>

" retarded 'more' kicks in
" noremap <Space>m :<C-u>marks<CR>:normal `

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
