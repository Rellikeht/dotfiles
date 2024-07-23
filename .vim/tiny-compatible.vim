"{{{ helpers

command! -nargs=1 -complete=arglist Argument 
            \ argedit <args>
            \ | argdedupe

command! -nargs=1 -complete=arglist ArgumentE
            \ argedit! <args>
            \ | argdedupe

command! -nargs=+ Silent
            \   execute 'silent! <args>'
            \   | redraw!

" Nope
" command! -nargs=1 -complete=arglist Vargument
"             \ vertical argument <args>
" command! -nargs=1 -complete=arglist Hargument
"             \ horizontal argument <args>
" command! -nargs=1 -complete=arglist Dargument
"             \ botright vertical argument <args>
" command! -nargs=1 -complete=arglist Rargument
"             \ botright horizontal argument <args>

"}}}

" {{{ basic mappings

" Because <C-w> is uncomfortable to press
map ; <C-w>
map ;; <C-w><C-w>

" Has to be that way
" <CR> is equal to <C-m> !!
noremap <C-m> <Tab>

noremap gy "*y
noremap gY "*Y
noremap gp "*gp
noremap gP "*gP

noremap <Tab>gy "+y
noremap <Tab>gY "+Y
noremap <Tab>gp "+gp
noremap <Tab>gP "+gP

" TODO D this is harder than it should be
noremap g+ v<C-a>
noremap g- v<C-x>
vnoremap + <C-a>
vnoremap - <C-x>

noremap <Space><Esc> <Nop>
noremap .<Esc> <Nop>

" }}}

"{{{ settings with <Space>

nnoremap <Space>qw :<C-u>setlocal wrap!<CR>
vnoremap <Space>qw :<C-u>setlocal wrap!\|norm gv<CR>
nnoremap <Space>qW :<C-u>set wrap!<CR>
vnoremap <Space>qW :<C-u>set wrap!\|norm gv<CR>
nnoremap <Space>qs :<C-u>source %<CR>
vnoremap <Space>qs :<C-u>source %\|norm gv<CR>
nnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e<CR>
vnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e\|norm gv<CR>
nnoremap <Space>qM :<C-u>setlocal modeline!<CR>
vnoremap <Space>qM :<C-u>setlocal modeline!\|norm gv<CR>

"}}}

" {{{ tabs with <Tab>

noremap <Tab>o :<C-u>tabedit<Space>
noremap <Tab>O :<C-u>-tabedit<Space>
noremap <Tab><Tab> :<C-u>tab<Space>
noremap <Tab>; :<C-u>-tab<Space>

noremap <Tab><Space>o :<C-u>tabedit  \|
            \ exe 'arglocal! '.expand('%')
            \ <C-Left><C-Left><C-Left><C-Left><Left>
noremap <Tab><Space>O :<C-u>-tabedit  \|
            \ exe 'arglocal! '.expand('%')
            \ <C-Left><C-Left><C-Left><C-Left><Left>

noremap <Tab>a :<C-u>tabnew\|arglocal!<Space>
noremap <Tab>A :<C-u>tabnew\|arglocal!<CR>

nnoremap <Tab>l :<C-u>tabs<CR>
vnoremap <Tab>l :<C-u>tabs\|norm gv<CR>
noremap <Tab><Space>l :filter  tabs<C-Left><Left>

noremap <silent> <Tab>+ :<C-u>tabnew<CR>
noremap <silent> <Tab>- :<C-u>tabclose<CR>
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

" {{{ resizing with <Tab>
" TODO C better
" TODO C more

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

noremap <Space><Space>e :<C-u>buffer<Space>
noremap <Space><Space>E :<C-u>buffer!<Space>
noremap <Space><Space>s <C-^>
noremap <Space><Space>o :<C-u>edit<Space>
noremap <Space><Space>O :<C-u>edit!<Space>

nnoremap <Space><Space>l :<C-u>buffers<CR>
vnoremap <Space><Space>l :<C-u>buffers\|norm gv<CR>
nnoremap <Space><Space>L :<C-u>buffers!<CR>
vnoremap <Space><Space>L :<C-u>buffers!\|norm gv<CR>
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

" c-g is good enough probably
" nnoremap <expr> <Space>ia (argc() == 0) ?
"             \ ':<C-u>echo "Argument list is empty"<CR>'
"             \ : ':<C-u>echo "Argument ".(argidx()+1)." of ".argc()<CR>'

noremap <Space>e :<C-u>Argument<Space>
noremap <Space>E :<C-u>ArgumentE<Space>
noremap <Space>o :<C-u>argedit<Space>
noremap <Space>O :<C-u>argedit!<Space>
nnoremap <Space>a :<C-u>argadd<CR>
vnoremap <Space>a :<C-u>argadd\|norm gv<CR>
nnoremap <Space>A :<C-u>argadd<Space>
vnoremap <Space>A :<C-u>argadd  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>d :<C-u>argdelete<Space>
vnoremap <Space>d :<C-u>argdelete  \|norm gv<C-Left><C-Left><Left>
noremap <silent> <Space>D :<C-u>if argc() == 1 
            \ \| q
            \ \| elseif argc() == 2
            \ \| argdelete
            \ \| first
            \ \| else
            \ \| argdelete
            \ \| if argidx() == argc() - 1
            \ \| argument 1
            \ \| else
            \ \| next
            \ \| endif
            \ \| endif<CR>

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
nnoremap <Space>_ :<C-u>argdedupe<CR>
vnoremap <Space>_ :<C-u>argdedupe\|norm gv<CR>
noremap <Space>: :<C-u>argdo<Space>
noremap <Space>;: :<C-u>argdo!<Space>

nnoremap <silent> <Space>w :<C-u>arglocal<CR>
vnoremap <silent> <Space>w :<C-u>arglocal\|norm gv<CR>
nnoremap <silent> <Space>W :<C-u>arglocal!<CR>
vnoremap <silent> <Space>W :<C-u>arglocal!\|norm gv<CR>
nnoremap <Space><Space>w :<C-u>arglocal<Space>
vnoremap <Space><Space>w :<C-u>arglocal  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>W :<C-u>arglocal!<Space>
vnoremap <Space><Space>W :<C-u>arglocal!  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>;w :<C-u>exe 'arglocal '.expand('%')<CR>
vnoremap <Space>;w :<C-u>exe 'arglocal '.expand('%')\|norm gv<CR>
nnoremap <Space>;W :<C-u>exe 'arglocal! '.expand('%')<CR>
vnoremap <Space>;W :<C-u>exe 'arglocal! '.expand('%')\|norm gv<CR>

nnoremap <silent> <Space>g :<C-u>argglobal<CR>
vnoremap <silent> <Space>g :<C-u>argglobal\|norm gv<CR>
nnoremap <silent> <Space>G :<C-u>argglobal!<CR>
vnoremap <silent> <Space>G :<C-u>argglobal!\|norm gv<CR>
nnoremap <Space><Space>g :<C-u>argglobal<Space>
vnoremap <Space><Space>g
            \ :<C-u>argglobal  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space><Space>G :<C-u>argglobal!<Space>
vnoremap <Space><Space>G
            \ :<C-u>argglobal!  \|norm gv<C-Left><C-Left><Left>

nnoremap <Space>;g :<C-u>exe 'argglobal '.expand('%')<CR>
vnoremap <Space>;g :<C-u>exe 'argglobal '.expand('%')\|norm gv<CR>
nnoremap <Space>;G :<C-u>exe 'argglobal! '.expand('%')<CR>
vnoremap <Space>;G :<C-u>exe 'argglobal! '.expand('%')\|norm gv<CR>

nnoremap <Space>u :<C-u>update<CR>
vnoremap <Space>u :<C-u>update\|norm gv<CR>
nnoremap <Space>U :<C-u>update!<CR>
vnoremap <Space>U :<C-u>update!\|norm gv<CR>
nnoremap <Space>;u :<C-u>update<Space>
vnoremap <Space>;u 
            \ :<C-u>update  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>;U :<C-u>update!<Space>
vnoremap <Space>;U
            \ :<C-u>update!  \|norm gv<C-Left><C-Left><Left>
nnoremap <Space>:u :<C-u>update ##<CR>
vnoremap <Space>:u :<C-u>update ## \|norm gv<CR>
nnoremap <Space>:U :<C-u>update! ##<CR>
vnoremap <Space>:U :<C-u>update! ## \|norm gv<CR>

"}}}

" {{{ splits with <Tab>

noremap <Tab>v :<C-u>vsplit<Space>
noremap <silent> <Tab>V :<C-u>vsplit<CR>
noremap <Tab>s :<C-u>split<Space>
noremap <silent> <Tab>S :<C-u>split<CR>
noremap <Tab>d :<C-u>botright split<Space>
noremap <silent> <Tab>D :<C-u>botright split<CR>
noremap <Tab>r :<C-u>botright vsplit<Space>
noremap <silent> <Tab>R :<C-u>botright vsplit<CR>

" Doesn't work
" noremap <Space>sv :<C-u>Vargument<Space>
" noremap <Space>ss :<C-u>Hargument<Space>
" noremap <Space>sd :<C-u>Dargument<Space>
" noremap <Space>sr :<C-u>Rargument<Space>

" }}}

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

nnoremap <Space>ik :<C-u>map<Space>
vnoremap <Space>ik :<C-u>map  \|norm gv
            \ <C-Left><C-Left><Left>
nnoremap <Space>in :<C-u>nmap<Space>
vnoremap <Space>in :<C-u>nmap  \|norm gv
            \ <C-Left><C-Left><Left>
nnoremap <Space>iv :<C-u>vmap<Space>
vnoremap <Space>iv :<C-u>vmap  \|norm gv
            \ <C-Left><C-Left><Left>
nnoremap <Space>ii :<C-u>imap<Space>
vnoremap <Space>ii :<C-u>imap  \|norm gv
            \ <C-Left><C-Left><Left>

noremap <Space>ih :<C-u>help<Space>
noremap <C-w><Space>ih :<C-u>tab help<Space>

" }}}

"{{{ <Space> operations

nnoremap <Space>iJ :<C-u>clearjumps<CR>
vnoremap <Space>iJ :<C-u>clearjumps\|norm gv<CR>

nnoremap <Space>;m :move<Space>

"}}}

"{{{ because escape doesn't work sometimes

noremap <Space>;<Esc> <Nop>
noremap <Space>i<Esc> <Nop>

"}}}

" {{{ other mappings

" Select whole buffer without plugins
vnoremap ae gg0oG$
nnoremap yae gg0vG$y`'

" }}}

" {{{ settings

" {{{ completion

set wildchar=<Tab>
set wildmode=list:longest,full
set wildoptions=fuzzy,tagfile,pum
set wildmenu
set wildignore+=*.o,*.elf,*.bin,*.dll,*.so

set complete=w,b,s,i,d,t,.,k

" }}}

" {{{ display

set noterse
set ruler
set number
set relativenumber

set showcmd
set showmode
set showmatch
set nohlsearch
" set textwidth=72

" }}}

" {{{ search

set history=2000
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
set wrapmargin=1

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

set cedit=<C-j>
set cmdwinheight=30

" }}}

" }}}

if v:progname =~? "^tv\\(im\\?\\)\\?" " {{{ 
    set background=dark
    set hlsearch
    set secure
    set modeline

    nnoremap <Tab><Space> :setlocal hls!<CR>
    vnoremap <Tab><Space> :setlocal hls!\|norm gv<CR>
    nnoremap <Tab>qh :<C-u>set hls!<CR>
    vnoremap <Tab>qh :<C-u>set hls!\|norm gv<CR>
endif
" }}}

if v:progname =~? "^nv\\(im\\?\\)\\?" " {{{
    set completeopt=menu,menuone,noselect,noinsert,preview
else
    set completeopt=menu,menuone,noselect,noinsert,preview,fuzzy,fuzzycollect
endif
" }}}
