" helpers {{{ 

command! -nargs=* -complete=file -count=1 Tabe
      \ <count>tabnew
      \ | arglocal!
      \ | args! <args>

command! -bang -nargs=? -complete=arglist Argument 
      \ if len(<q-args>) == 0
      \ | argument
      \ | else
      \ | exe "argedit<bang> <args>"
      \ | argdedupe
      \ | endif

command! -nargs=+ Silent
      \ execute 'silent! <args>'
      \ | redraw!

command! -nargs=1 -complete=arglist TabA
      \ Tabe <args>

command! -nargs=1 -complete=buffer TabB
      \ Tabe <args>

" Nope
" command! -nargs=1 -complete=arglist Vargument
"             \vertical argument <args>
" command! -nargs=1 -complete=arglist Hargument
"             \horizontal argument <args>
" command! -nargs=1 -complete=arglist Dargument
"             \botright vertical argument <args>
" command! -nargs=1 -complete=arglist Rargument
"             \botright horizontal argument <args>

command -nargs=1 -complete=file ArgView
      \ argedit +silent!\ view <args>

" }}} 

" basic mappings {{{ 

noremap <C-j> <Tab>

nnoremap <Space>y "+y
nnoremap <Space>Y "+Y
nnoremap <Tab>y "*y
nnoremap <Tab>Y "*Y
nnoremap <Space>u "+p
nnoremap <Space>U "+P
nnoremap <Tab>u "*p
nnoremap <Tab>U "*P

xnoremap <Space>y "+y
xnoremap <Space>Y "+Y
xnoremap <Tab>y "*y
xnoremap <Tab>Y "*Y
xnoremap <Space>u "+p
xnoremap <Space>U "+P
xnoremap <Tab>u "*p
xnoremap <Tab>U "*P

" TODO D this is harder than it should be
" noremap g+ v<C-a>
" noremap g- v<C-x>

nnoremap <Space><Tab> <C-^>

" }}} 

" nops, mostly because escape doesn't work sometimes {{{ 

map <Space> <Nop>
map <Space><Space> <Nop>

noremap <Space>;<Esc> <Nop>
noremap <Space>i<Esc> <Nop>

" not that comfortable
" map . <Nop>

" }}} 

" settings with <Space> {{{ 

nnoremap <Space>qw :<C-u>setlocal wrap!<CR>
nnoremap <Space>qW :<C-u>set wrap!<CR>
nnoremap <Space>qs :<C-u>source %<CR>
nnoremap <Space>qm :<C-u>setlocal modeline!<CR>:e<CR>
nnoremap <Space>qM :<C-u>setlocal modeline!<CR>
nnoremap <Space>qh :<C-u>set hls!<CR>

" }}} 

" tabs with <Tab> {{{ 

nnoremap <Tab>o :<C-u>Tabe<Space>
nnoremap <Tab>O :<C-u>-Tabe<Space>
nnoremap <Tab><Space>o :<C-u>TabA<Space>
nnoremap <Tab><Space>O :<C-u>-TabA<Space>
nnoremap <Tab>;o :<C-u>TabA<Space>
nnoremap <Tab>;O :<C-u>-TabA<Space>

nnoremap <silent> <expr> <Tab>;e
      \(v:count ? ':<C-u>exe "tabnext "'.v:count.'<CR>' : '')
nnoremap <Tab><Tab> :<C-u>tab<Space>
nnoremap <Tab><S-Tab> :<C-u>-tab<Space>

" TODO B logic
nnoremap <Tab>gp :<C-u>tabfind<Space>
nnoremap <Tab>gP :<C-u>-tabfind<Space>

nnoremap <Tab><Space>o :<C-u>Tabe  \|
      \exe 'arglocal! '.fnameescape(expand('%'))
      \<Home><C-Right><Right>
nnoremap <Tab><Space>O :<C-u>-Tabe  \|
      \exe 'arglocal! '.fnameescape(expand('%'))
      \<Home><C-Right><Right>

" noremap <Tab>a :<C-u>tabnew\|arglocal!<Space>
" noremap <Tab>A :<C-u>tabnew\|arglocal!<CR>

nnoremap <Tab>l :<C-u>tabs<CR>
nnoremap <Tab><Space>l :filter  tabs<C-Left><Left>

nnoremap <silent> <Tab>+ :<C-u>tabnew<CR>
nnoremap <silent> <Tab>- :<C-u>tabclose<CR>gT
nnoremap <silent> <Tab>! :<C-u>tabonly<CR>
nnoremap <Tab>b :<C-u>tab<Space>sb<Space>
nnoremap <Tab>B :<C-u>-tab<Space>sb<Space>

nnoremap <silent> <Tab>0 :<C-u>tabfirst<CR>
nnoremap <silent> <Tab>$ :<C-u>tablast<CR>
nnoremap <Tab>n gt
nnoremap <Tab>p gT

nnoremap <Tab>m :<C-u>tabm<Space>
nnoremap <silent> <Tab>N :<C-u>tabm +1<CR>
nnoremap <silent> <Tab>P :<C-u>tabm -1<CR>
nnoremap <silent> <Tab>J :<C-u>tabm $<CR>
nnoremap <silent> <Tab>K :<C-u>tabm 0<CR>

nnoremap <Tab>: :<C-u>tabdo<Space>

" }}} 

" TODO C refine - resizing with <Tab> {{{ 

nnoremap <silent> <Tab>>1 :<C-u>vertical resize 10<CR>
nnoremap <silent> <Tab>>2 :<C-u>vertical resize 20<CR>
nnoremap <silent> <Tab>>3 :<C-u>vertical resize 30<CR>
nnoremap <silent> <Tab>>4 :<C-u>vertical resize 40<CR>
nnoremap <silent> <Tab>>5 :<C-u>vertical resize 50<CR>
nnoremap <Tab>>r :<C-u>vertical resize <Space>

nnoremap <silent> <Tab>>= :<C-u>vertical resize +1<CR>
nnoremap <silent> <Tab>>+ :<C-u>vertical resize +5<CR>
nnoremap <silent> <Tab>>a :<C-u>vertical resize +10<CR>
nnoremap <silent> <Tab>>A :<C-u>vertical resize +20<CR>
nnoremap <silent> <Tab>>- :<C-u>vertical resize -1<CR>
nnoremap <silent> <Tab>>_ :<C-u>vertical resize -5<CR>
nnoremap <silent> <Tab>>d :<C-u>vertical resize -10<CR>
nnoremap <silent> <Tab>>D :<C-u>vertical resize -20<CR>

nnoremap <silent> <Tab>^1 :<C-u>resize 10<CR>
nnoremap <silent> <Tab>^2 :<C-u>resize 20<CR>
nnoremap <silent> <Tab>^3 :<C-u>resize 30<CR>
nnoremap <silent> <Tab>^4 :<C-u>resize 40<CR>
nnoremap <silent> <Tab>^5 :<C-u>resize 50<CR>
nnoremap <silent> <Tab>^r :<C-u>resize <Space>

nnoremap <silent> <Tab>^= :<C-u>resize +1<CR>
nnoremap <silent> <Tab>^+ :<C-u>resize +5<CR>
nnoremap <silent> <Tab>^a :<C-u>resize +10<CR>
nnoremap <silent> <Tab>^A :<C-u>resize +20<CR>
nnoremap <silent> <Tab>^- :<C-u>resize -1<CR>
nnoremap <silent> <Tab>^_ :<C-u>resize -5<CR>
nnoremap <silent> <Tab>^d :<C-u>resize -10<CR>
nnoremap <silent> <Tab>^D :<C-u>resize -20<CR>

" }}} 

" buffers with <Space><Space> {{{ 

nnoremap <Space><Space>e :<C-u>buffer<Space>
nnoremap <Space><Space>E :<C-u>buffer!<Space>
nnoremap <silent> <Space><Space>;e :<C-u>exe
      \'buffer '.(v:count ? v:count : '')<CR>
nnoremap <silent> <Space><Space>;E :<C-u>exe
      \'buffer! '.(v:count ? v:count : '')<CR>
nnoremap <Space><Space>s <C-^>
nnoremap <Space><Space>o :<C-u>edit<Space>
nnoremap <Space><Space>O :<C-u>edit!<Space>
nnoremap <Space><Space>r :<C-u>view<Space>
nnoremap <Space><Space>R :<C-u>view!<Space>

nnoremap <silent> <Space><Space>+ :<C-u>enew<CR>
nnoremap <silent> <Space><Space>- :<C-u>bdelete<CR>
nnoremap <silent> <Space><Space>;- :<C-u>bdelete!<CR>

nnoremap <Space><Space>l :<C-u>buffers<CR>
nnoremap <Space><Space>L :<C-u>buffers!<CR>
nnoremap <Space><Space>;l :<C-u>filter  buffers<C-Left><Left>
nnoremap <Space><Space>;L :<C-u>filter  buffers!<C-Left><Left>

nnoremap <silent> <Space><Space>n :<C-u>bnext<CR>
nnoremap <silent> <Space><Space>p :<C-u>bprevious<CR>
nnoremap <silent> <Space><Space>N :<C-u>bnext!<CR>
nnoremap <silent> <Space><Space>P :<C-u>bprevious!<CR>
nnoremap <silent> <Space><Space>m :<C-u>bmodified<CR>
nnoremap <silent> <Space><Space>M :<C-u>bmodified!<CR>

nnoremap <silent> <Space><Space>0 :<C-u>bfirst<CR>
nnoremap <silent> <Space><Space>0 :<C-u>bfirst!<CR>
nnoremap <Space><Space>;0 :<C-u>bfirst<Space>
nnoremap <Space><Space>;0 :<C-u>bfirst!<Space>
nnoremap <silent> <Space><Space>$ :<C-u>blast<CR>
nnoremap <silent> <Space><Space>$ :<C-u>blast!<CR>
nnoremap <Space><Space>;$ :<C-u>blast<Space>
nnoremap <Space><Space>;$ :<C-u>blast!<Space>

nnoremap <silent> <Space><Space>d :<C-u>bunload<CR>
nnoremap <silent> <Space><Space>D :<C-u>bunload!<CR>
nnoremap <silent> <Space><Space>w :<C-u>bwipeout<CR>
nnoremap <silent> <Space><Space>W :<C-u>bwipeout!<CR>

nnoremap <Space><Space>;n :<C-u>bnext<Space>
nnoremap <Space><Space>;p :<C-u>bprevious<Space>
nnoremap <Space><Space>;N :<C-u>bnext!<Space>
nnoremap <Space><Space>;P :<C-u>bprevious!<Space>
nnoremap <Space><Space>;m :<C-u>bmodified<Space>
nnoremap <Space><Space>;M :<C-u>bmodified!<Space>

nnoremap <Space><Space>A :<C-u>balt<Space>
nnoremap <Space><Space>a :<C-u>badd<Space>
nnoremap <Space><Space>;d :<C-u>bdelete<Space>
nnoremap <Space><Space>;D :<C-u>bdelete!<Space>
nnoremap <Space><Space>;u :<C-u>bunload<Space>
nnoremap <Space><Space>;U :<C-u>bunload!<Space>
nnoremap <Space><Space>;w :<C-u>bwipeout<Space>
nnoremap <Space><Space>;W :<C-u>bwipeout!<Space>

nnoremap <Space><Space>: :<C-u>bufdo<Space>
nnoremap <Space><Space>;: :<C-u>bufdo!<Space>

" }}} 

" args with <Space> {{{ 

nnoremap <Space>l :<C-u>args<CR>
nnoremap <Space>;l :<C-u>filter  args<C-Left><Left>

nnoremap <Space>e :<C-u>Argument<Space>
nnoremap <Space>E :<C-u>Argument!<Space>
nnoremap <silent> <Space>;e :<C-u>exe
      \ 'argument '.(v:count ? v:count : '')<CR>
nnoremap <silent> <Space>;E :<C-u>exe
      \ 'argument! '.(v:count ? v:count : '')<CR>
nnoremap <Space>o :<C-u>argedit<Space>
nnoremap <Space>O :<C-u>argedit!<Space>
nnoremap <Space>r :<C-u>ArgView<Space>
nnoremap <Space>R :<C-u>ArgView!<Space>

nnoremap <Space>a :<C-u>argadd<Space>
nnoremap <silent> <Space>A :<C-u>argadd\|next<CR>
nnoremap <Space>d :<C-u>argdelete<Space>
nnoremap <silent> <Space>D :<C-u>if argc() == 1
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
" TODO <Space>;D

nnoremap <silent> <Space>n :<C-u>next<CR>
nnoremap <silent> <Space>N :<C-u>next!<CR>
nnoremap <Space><Space>n :<C-u>next<Space>
nnoremap <Space><Space>N :<C-u>next!<Space>
nnoremap <silent> <Space>p :<C-u>previous<CR>
nnoremap <silent> <Space>P :<C-u>previous!<CR>
nnoremap <Space><Space>p :<C-u>previous<Space>
nnoremap <Space><Space>P :<C-u>previous!<Space>

nnoremap <silent> <Space>. :<C-u>wnext<CR>
nnoremap <silent> <Space>> :<C-u>wnext!<CR>
nnoremap <Space><Space>. :<C-u>wnext<Space>
nnoremap <Space><Space>> :<C-u>wnext!<Space>
nnoremap <silent> <Space>, :<C-u>wprevious<CR>
nnoremap <silent> <Space>< :<C-u>wprevious!<CR>
nnoremap <Space><Space>, :<C-u>wprevious<Space>
nnoremap <Space><Space>< :<C-u>wprevious!<Space>

nnoremap <silent> <Space>0 :<C-u>first<CR>
nnoremap <silent> <Space>0 :<C-u>first!<CR>
nnoremap <Space>;0 :<C-u>first<Space>
nnoremap <Space>;0 :<C-u>first!<Space>
nnoremap <silent> <Space>$ :<C-u>last<CR>
nnoremap <silent> <Space>$ :<C-u>last!<CR>
nnoremap <Space>;$ :<C-u>last<Space>
nnoremap <Space>;$ :<C-u>last!<Space>

nnoremap <Space>= :<C-u>args!<Space>
nnoremap <Space>@ :<C-u>argdedupe<CR>
nnoremap <Space>: :<C-u>argdo<Space>
nnoremap <Space>;: :<C-u>argdo!<Space>

nnoremap <silent> <Space>ql :<C-u>arglocal<CR>
nnoremap <silent> <Space>qL :<C-u>arglocal!<CR>
nnoremap <Space>q<Space>l :<C-u>arglocal<Space>
nnoremap <Space>q<Space>L :<C-u>arglocal!<Space>
nnoremap <Space>qf :<C-u>exe 'arglocal '.fnameescape(expand('%'))<CR>
nnoremap <Space>qF :<C-u>exe 'arglocal! '.fnameescape(expand('%'))<CR>

nnoremap <silent> <Space>qg :<C-u>argglobal<CR>
nnoremap <silent> <Space>qG :<C-u>argglobal!<CR>
nnoremap <Space>q<Space>g :<C-u>argglobal<Space>
nnoremap <Space>q<Space>G :<C-u>argglobal!<Space>

" }}} 

" splits with <Tab> {{{ 

nnoremap <Tab>sv :<C-u>vsplit<Space>
nnoremap <Tab>ss :<C-u>split<Space>
nnoremap <Tab>sd :<C-u>botright split<Space>
nnoremap <Tab>sr :<C-u>botright vsplit<Space>

" Doesn't work
" noremap <Space>sv :<C-u>Vargument<Space>
" noremap <Space>ss :<C-u>Hargument<Space>
" noremap <Space>sd :<C-u>Dargument<Space>
" noremap <Space>sr :<C-u>Rargument<Space>

" }}} 

" <Space> list and help {{{ 

nnoremap <Space>ie :<C-u>oldfiles<CR>
nnoremap <Space>ir :<C-u>registers<CR>
nnoremap <Space>ip :<C-u>history<CR>
nnoremap <Space>ic :<C-u>changes<CR>
nnoremap <Space>ij :<C-u>jumps<CR>
nnoremap <Space>io :<C-u>files<CR>
nnoremap <Space>im :<C-u>marks<CR>
nnoremap <Space>ig :<C-u>marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>

nnoremap <Space>i<Space>e
      \:<C-u>filter  oldfiles<C-Left><Left>
nnoremap <Space>i<Space>r
      \:<C-u>filter  registers<C-Left><Left>
nnoremap <Space>i<Space>p
      \:<C-u>filter  history<C-Left><Left>
nnoremap <Space>i<Space>c
      \:<C-u>filter  changes<C-Left><Left>
nnoremap <Space>i<Space>j
      \:<C-u>filter  jumps<C-Left><Left>
nnoremap <Space>i<Space>o
      \:<C-u>filter  files<C-Left><Left>
nnoremap <Space>i<Space>m
      \:<C-u>filter  marks<C-Left><Left>

nnoremap <Space>ikk :<C-u>map<Space>
nnoremap <Space>ikn :<C-u>nmap<Space>
nnoremap <Space>ikv :<C-u>vmap<Space>
nnoremap <Space>iki :<C-u>imap<Space>
nnoremap <Space>ikc :<C-u>cmap<Space>

nnoremap <space>i<space>n :g//#<Left><Left>

nnoremap <Space>ih :<C-u>help<Space>
" nnoremap <C-w><Space>ih :<C-u>tab help<Space>
nnoremap <Tab>h :<C-u>tab help<Space>
nnoremap <Tab>H :<C-u>-tab help<Space>

" }}} 

" <Space> operations {{{ 

nnoremap <Space>qu :<C-u>update<CR>
nnoremap <Space>qU :<C-u>update!<CR>
nnoremap <Space><Space>qu :<C-u>update<Space>
nnoremap <Space><Space>qU :<C-u>update!<Space>
nnoremap <Space>q;u :<C-u>update ##<CR>
nnoremap <Space>q;U :<C-u>update! ##<CR>

nnoremap <Space>iJ :<C-u>clearjumps<CR>

nnoremap <Space>;m :move<Space>
noremap <Space>_ "_d

" }}} 

" other mappings {{{ 

" Select whole buffer without plugins
vnoremap aee gg0oG$
vnoremap iee aee
nnoremap yaee gg0vG$y`'

" }}} 

" settings {{{ 

" completion {{{ 

set wildchar=<Tab>
set wildmode=list:longest,full
set wildoptions=fuzzy,tagfile,pum
set wildmenu
set wildignore+=*.o,*.elf,*.bin,*.dll,*.so

set complete=w,b,s,i,d,.,k
set completeopt=menu,menuone,noselect,noinsert,preview

" }}} 

" display {{{ 

" set terse
set ruler
set number
set relativenumber

set showcmd
set showmode
set showmatch
set nohlsearch
" set textwidth=72

" }}} 

" search {{{ 

set history=10000
set incsearch
set ignorecase
set smartcase

" }}} 

" indent {{{ 

set autoindent
set cindent
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set breakindent

" }}} 

" ui {{{ 

set linebreak

set nowrap
set showbreak=\\>\ 
set wrapmargin=1

set notimeout
set ttimeout
set ttimeoutlen=100

set mouse=a
" set clipboard=unnamed
set clipboard=

set switchbuf+=usetab,useopen

" }}} 

" editing {{{ 

set formatoptions=croqlwn

" Neovim default setting at time of writing this
set backspace=indent,eol,start

set undolevels=10000

" }}} 

" other {{{ 

set background=dark

set noautoread
set noautochdir
if !has("nvim")
  set termencoding=utf-8
endif

set modelines=3
set hidden
set secure

set cedit=<C-j>
set cmdwinheight=30

" }}} 

" only for tiny vim !!! {{{

set modeline

map <C-p> ,
" = gets tricked by this comma
map <C-n> ;

" }}}

" files {{{ 

set encoding=utf-8
set fileformat=unix

" }}} 

" }}} 
