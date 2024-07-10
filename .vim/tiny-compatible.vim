" {{{ basic mappings

" Because <C-w> is uncomfortable to press

map _ <C-w>
map __ <C-w><C-w>

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

" TODO counts

" {{{ tabs with <Tab>

noremap <Tab>e :tabedit<Space>
noremap <Tab>E :-tabedit<Space>
noremap <Tab>o :tab<Space>
noremap <Tab>O :-tab<Space>

nnoremap <Tab>l :tabs<CR>
nnoremap <Tab><Space>l :filter  tabs<C-Left><C-b>
nnoremap <Tab>;l :filter // tabs<C-Left><C-b><C-b>

noremap <silent> <Tab>+ :tabnew<CR>
noremap <silent> <Tab>- :tabclose<CR>
noremap <silent> <Tab>! :tabonly<CR>

noremap <Tab>b :tab<Space>sb<Space>
noremap <Tab>B :-tab<Space>sb<Space>

noremap <silent> <Tab>0 :tabfirst<CR>
noremap <silent> <Tab>$ :tablast<CR>
noremap <Tab>n gt
noremap <Tab>p gT

noremap <Tab>m :tabm<Space>
noremap <silent> <Tab>L :tabm +1<CR>
noremap <silent> <Tab>H :tabm -1<CR>
noremap <silent> <Tab>J :tabm $<CR>
noremap <silent> <Tab>K :tabm 0<CR>

noremap <Tab>t :tabdo<Space>

" }}}

" {{{ TODO windows with <Tab>

noremap <silent> <Tab>v :vsplit<Space>
noremap <silent> <Tab>V :vsplit<CR>
noremap <silent> <Tab>s :split<Space>
noremap <silent> <Tab>S :split<CR>
noremap <silent> <Tab>u :botright split<Space>
noremap <silent> <Tab>U :botright split<CR>
noremap <silent> <Tab>g :botright vsplit<Space>
noremap <silent> <Tab>G :botright vsplit<CR>

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

" TODO splits with <CR> ?

" {{{ buffers with <Space>

noremap <Space>b :buffer<Space>
noremap <Space>B :buffer!<Space>

noremap <Space>l :buffers<CR>
noremap <Space><Space>l :filter  buffers<C-Left><C-b>
noremap <Space>;l :filter // buffers<C-Left><C-b><C-b>
noremap <Space>L :buffers<CR>
noremap <Space><Space>L :filter  buffers<C-Left><C-b>
noremap <Space>;L :filter // buffers<C-Left><C-b><C-b>

noremap <silent> <Space>n :bnext<CR>
noremap <silent> <Space>p :bprevious<CR>
noremap <silent> <Space>N :bnext!<CR>
noremap <silent> <Space>P :bprevious!<CR>
noremap <silent> <Space>m :bmodified<CR>
noremap <silent> <Space>M :bmodified!<CR>

noremap <silent> <Space>d :bdelete<CR>
noremap <silent> <Space>D :bdelete!<CR>
noremap <silent> <Space>u :bunload<CR>
noremap <silent> <Space>U :bunload!<CR>
noremap <silent> <Space>w :bwipeout<CR>
noremap <silent> <Space>W :bwipeout!<CR>

noremap <silent> <Space><Space>n :bnext<Space>
noremap <silent> <Space><Space>p :bprevious<Space>
noremap <silent> <Space><Space>N :bnext!<Space>
noremap <silent> <Space><Space>P :bprevious!<Space>
noremap <silent> <Space><Space>m :bmodified<Space>
noremap <silent> <Space><Space>M :bmodified!<Space>

noremap <silent> <Space><Space>d :bdelete<Space>
noremap <silent> <Space><Space>D :bdelete!<Space>
noremap <silent> <Space><Space>u :bunload<Space>
noremap <silent> <Space><Space>U :bunload!<Space>
noremap <silent> <Space><Space>w :bwipeout<Space>
noremap <silent> <Space><Space>W :bwipeout!<Space>

noremap <Space>a :badd<Space>
noremap <Space>A :balt<Space>
noremap <Space>t :bufdo<Space>
noremap <Space>T :bufdo!<Space>

" }}}

"{{{ args with ;

noremap ;l :args<CR>
noremap ;<Space>l :filter  args<C-Left><C-b>
noremap ;;l :filter // args<C-Left><C-b><C-b>
noremap ;L :args!<Space>

noremap ;a :argadd<Space>
noremap ;d :argdelete<Space>
noremap ;e :argedit<Space>
noremap ;E :argedit!<Space>
noremap ;o :argument<Space>
noremap ;O :argument!<Space>

noremap ;n :next<CR>
noremap ;N :next!<CR>
noremap ;;n :next<Space>
noremap ;;N :next!<CR>
noremap ;p :previous<CR>
noremap ;P :previous!<CR>
noremap ;;p :previous<Space>
noremap ;;P :previous!<Space>

noremap ;. :wnext<CR>
noremap ;> :wnext!<CR>
noremap ;;. :wnext<Space>
noremap ;;> :wnext!<Space>
noremap ;, :wprevious<CR>
noremap ;< :wprevious!<CR>
noremap ;;, :wprevious<Space>
noremap ;;< :wprevious!<Space>

noremap ;0 :last<CR>
noremap ;0 :last!<CR>
noremap ;;0 :last<Space>
noremap ;;0 :last!<Space>
noremap ;$ :last<CR>
noremap ;$ :last!<CR>
noremap ;;$ :last<Space>
noremap ;;$ :last!<Space>

noremap ;= :argdedupe<CR>
noremap ;t :argdo<Space>
noremap ;T :argdo!<Space>

" TODO local args

"}}}

" {{{ <Space> list and help

nnoremap <Space>ir :registers<CR>
nnoremap <Space>ip :history<CR>
nnoremap <Space>im :marks<CR>
nnoremap <Space>ic :changes<CR>
nnoremap <Space>ij :jumps<CR>
nnoremap <Space>if :files<CR>

nnoremap <Space><Space>ir :filter  registers<C-Left><C-b>
nnoremap <Space><Space>ip :filter  history<C-Left><C-b>
nnoremap <Space><Space>im :filter  marks<C-Left><C-b>
nnoremap <Space><Space>ic :filter  changes<C-Left><C-b>
nnoremap <Space><Space>ij :filter  jumps<C-Left><C-b>
nnoremap <Space><Space>if :filter  files<C-Left><C-b>

nnoremap <Space>;ir :filter // registers<C-Left><C-b><C-b>
nnoremap <Space>;ip :filter // history<C-Left><C-b><C-b>
nnoremap <Space>;im :filter // marks<C-Left><C-b><C-b>
nnoremap <Space>;ic :filter // changes<C-Left><C-b><C-b>
nnoremap <Space>;ij :filter // jumps<C-Left><C-b><C-b>
nnoremap <Space>;if :filter // files<C-Left><C-b><C-b>

nnoremap <Space>ik :map<Space>
nnoremap <Space>in :nmap<Space>
nnoremap <Space>iv :vmap<Space>
nnoremap <Space>ii :imap<Space>

nnoremap <Space>ih :help<Space>
nnoremap <C-w><Space>ih :tab help<Space>

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

"{{{ free control combinations

"|<BS>|		<BS>		1  same as "h"
"|CTRL-H|	CTRL-H		1  same as "h"
"|CTRL-J|	CTRL-J		1  same as "j"
"		CTRL-K		   not used
"|<CR>|		<CR>		1  cursor to the first CHAR N lines lower
"|CTRL-M|	CTRL-M		1  same as <CR>
"|CTRL-N|	CTRL-N		1  same as "j"
"|CTRL-P|	CTRL-P		1  same as "k"
"|CTRL-R|	CTRL-R		2  redo changes which were undone with 'u'
"|CTRL-\_CTRL-N|	CTRL-\ CTRL-N	   go to Normal mode (no-op)
"|CTRL-\_CTRL-G|	CTRL-\ CTRL-G	   go to mode specified with 'insertmode'
"		CTRL-\ others	   not used
"		CTRL-_		   not used

"		}}}
