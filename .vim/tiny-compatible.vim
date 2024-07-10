" {{{ basic mappings

" Works (as map too)
map <Space> <C-w>
map <Space><Space> <C-w><C-w>

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

"{{{ settings with <tab>

noremap <Tab>qw :set wrap!<CR>
noremap <Tab>qs :source %<CR>
noremap <Tab>qm :setlocal modeline!<CR>:e<CR>
noremap <Tab>qM :setlocal modeline!<CR>

"}}}

" {{{ tabs with <Tab>

noremap <silent> <Tab>0 :tabfirst<CR>
noremap <silent> <Tab>$ :tablast<CR>
noremap <Tab>l gt
noremap <Tab>h gT
noremap <Tab>t :tabedit<Space>
noremap <Tab>T :-tabedit<Space>
noremap <Tab>m :tabm<Space>
noremap <silent> <Tab>d :tabclose<CR>
noremap <silent> <Tab>L :tabm +1<CR>
noremap <silent> <Tab>H :tabm -1<CR>
noremap <silent> <Tab>J :tabm $<CR>
noremap <silent> <Tab>K :tabm 0<CR>
noremap <Tab>e :tab<Space>sb<Space>
noremap <Tab>E :-tab<Space>sb<Space>
noremap <silent> <Tab>O :tabnew<CR>

noremap <Tab><Tab> :tab<Space>
noremap <Tab>: :-tab<Space>

" }}}

" {{{ windows with <Tab>

" TODO more resizing

noremap <Tab>>1 :vertical resize 10<CR>
noremap <Tab>>2 :vertical resize 20<CR>
noremap <Tab>>3 :vertical resize 30<CR>
noremap <Tab>>4 :vertical resize 40<CR>
noremap <Tab>>5 :vertical resize 50<CR>
noremap <Tab>>r :vertical resize <Space>

noremap <Tab>>= :vertical resize +1<CR>
noremap <Tab>>+ :vertical resize +5<CR>
noremap <Tab>>a :vertical resize +10<CR>
noremap <Tab>>A :vertical resize +20<CR>
noremap <Tab>>- :vertical resize -1<CR>
noremap <Tab>>_ :vertical resize -5<CR>
noremap <Tab>>d :vertical resize -10<CR>
noremap <Tab>>D :vertical resize -20<CR>

noremap <Tab>^1 :resize 10<CR>
noremap <Tab>^2 :resize 20<CR>
noremap <Tab>^3 :resize 30<CR>
noremap <Tab>^4 :resize 40<CR>
noremap <Tab>^5 :resize 50<CR>
noremap <Tab>^r :resize <Space>

noremap <Tab>^= :resize +1<CR>
noremap <Tab>^+ :resize +5<CR>
noremap <Tab>^a :resize +10<CR>
noremap <Tab>^A :resize +20<CR>
noremap <Tab>^- :resize -1<CR>
noremap <Tab>^_ :resize -5<CR>
noremap <Tab>^d :resize -10<CR>
noremap <Tab>^D :resize -20<CR>

" }}}

" {{{ buffers with <Tab> TODO ctrl

noremap <Tab>b :buffer<Space>
noremap <silent> <Tab>n :bnext<CR>
noremap <silent> <Tab>p :bprevious<CR>
noremap <silent> <Tab>N :bnext!<CR>
noremap <silent> <Tab>P :bprevious!<CR>
noremap <silent> <Tab>D :bdelete<CR>
noremap <silent> <Tab>U :bunload<CR>
noremap <Tab>a :badd<Space>
noremap <Tab>A :balt<Space>
noremap <silent> <Tab>c :bmodified<CR>
noremap <silent> <Tab>C :bmodified!<CR>

noremap <silent> <Tab>v :vsplit<Space>
noremap <silent> <Tab>V :vsplit<CR>
noremap <silent> <Tab>s :split<Space>
noremap <silent> <Tab>S :split<CR>
noremap <silent> <Tab>u :botright split<Space>
noremap <silent> <Tab>U :botright split<CR>
noremap <silent> <Tab>g :botright vsplit<Space>
noremap <silent> <Tab>G :botright vsplit<CR>

noremap <Tab>o :bufdo<Space>

" }}}

"{{{ args with <tab> TODO ;

noremap <Tab>;a :argadd<CR>
noremap <Tab>;A :argadd<Space>
noremap <Tab>;d :argdelete<CR>
noremap <Tab>;D :argdelete<Space>

noremap <Tab>;n :next<CR>
noremap <Tab>;N :next<Space>
noremap <Tab>;p :previous<CR>
noremap <Tab>;P :previous<Space>
noremap <Tab>;h :first<CR>
noremap <Tab>;l :last<CR>

noremap <Tab>;. :wnext<CR>
noremap <Tab>;> :wnext!<CR>
noremap <Tab>;, :wprevious<CR>
noremap <Tab>;< :wprevious!<CR>

noremap <Tab>;r :argdedupe<CR>
noremap <Tab>;e :argument<Space>
noremap <Tab>;E :argument!<Space>
noremap <Tab>;o :argedit<Space>
nnoremap <Tab>;O :args<Space>

"}}}

"{{{ TODO local args with ???

"}}}

" {{{ other tab mappings

nnoremap <Tab>ir :registers<CR>
nnoremap <Tab>ih :history<CR>
nnoremap <Tab>im :marks<CR>
nnoremap <Tab>ic :changes<CR>
nnoremap <Tab>ij :jumps<CR>
nnoremap <Tab>ia :args<CR>

nnoremap <Tab>if :files<CR>
nnoremap <Tab>ib :buffers<CR>
nnoremap <Tab>it :tabs<CR>

nnoremap <Tab>fr :filter  registers<C-Left><C-b>
nnoremap <Tab>fh :filter  history<C-Left><C-b>
nnoremap <Tab>fm :filter  marks<C-Left><C-b>
nnoremap <Tab>fc :filter  changes<C-Left><C-b>
nnoremap <Tab>fj :filter  jumps<C-Left><C-b>
nnoremap <Tab>fa :filter  args<C-Left><C-b>

nnoremap <Tab>ff :filter  files<C-Left><C-b>
nnoremap <Tab>fb :filter  buffers<C-Left><C-b>
nnoremap <Tab>ft :filter  tabs<C-Left><C-b>
nnoremap <Tab>f<Space> :filter<Space>

nnoremap <Tab>ik :map<Space>
nnoremap <Tab>in :nmap<Space>
nnoremap <Tab>iv :vmap<Space>
nnoremap <Tab>ii :imap<Space>

nnoremap <Tab>id :help<Space>
nnoremap <C-w><Tab>id :tab help<Space>

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
set wildmode=list:full,full
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
set showbreak=\\>>

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
