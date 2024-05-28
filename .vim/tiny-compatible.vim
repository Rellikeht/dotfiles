" KEYS

map <Space> <C-w>
" Nope
noremap gy "*y
noremap gY "+y
" noremap gy "*gP
" noremap gY "+gP

" TODO this is harder than it should be
noremap g+ v<C-a>
noremap g- v<C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" Tabs with <Tab>
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

" Buffers with <Tab>
noremap <Tab>b :buffer<Space>
noremap <silent> <Tab>n :bnext<CR>
noremap <silent> <Tab>p :bprevious<CR>
noremap <silent> <Tab>N :bnext!<CR>
noremap <silent> <Tab>P :bprevious!<CR>
noremap <silent> <Tab>D :bdelete<CR>
noremap <silent> <Tab>U :bunload<CR>
noremap <silent> <Tab>s :sbprevious<CR>
noremap <silent> <Tab>S :sbnext<CR>
noremap <silent> <Tab>v :vsplit<CR>:bnext<CR>
noremap <silent> <Tab>V :vsplit<CR>:bprevious<CR>
noremap <Tab>a :badd<Space>
noremap <Tab>A :balt<Space>
noremap <silent> <Tab>c :bmodified<CR>
noremap <silent> <Tab>C :bmodified!<CR>
noremap <Tab>g :vsplit<Space>
noremap <Tab>G :split<Space>

" Windows

noremap <Tab>>1 :vertical resize 10<CR>
noremap <Tab>>2 :vertical resize 20<CR>
noremap <Tab>>3 :vertical resize 30<CR>
noremap <Tab>>4 :vertical resize 40<CR>
noremap <Tab>>5 :vertical resize 50<CR>
noremap <Tab>>r :vertical resize <Space>

noremap <Tab>>+ :vertical resize +1<CR>
noremap <Tab>>a :vertical resize +5<CR>
noremap <Tab>>A :vertical resize +10<CR>
noremap <Tab>>- :vertical resize -1<CR>
noremap <Tab>>d :vertical resize -5<CR>
noremap <Tab>>D :vertical resize -10<CR>

noremap <Tab>^1 :resize 10<CR>
noremap <Tab>^2 :resize 20<CR>
noremap <Tab>^3 :resize 30<CR>
noremap <Tab>^4 :resize 40<CR>
noremap <Tab>^5 :resize 50<CR>
noremap <Tab>^r :resize <Space>

noremap <Tab>^+ :resize +1<CR>
noremap <Tab>^a :resize +5<CR>
noremap <Tab>^A :resize +10<CR>
noremap <Tab>^- :resize -1<CR>
noremap <Tab>^d :resize -5<CR>
noremap <Tab>^D :resize -10<CR>


" Others
noremap <Tab>W :set wrap!<CR>
noremap <Tab>Q :source %<CR>
noremap <Tab>M :setlocal modeline!<CR>

nnoremap <tab>ir :registers<CR>
nnoremap <tab>ib :buffers<CR>
nnoremap <tab>if :files<CR>
nnoremap <tab>it :tabs<CR>
nnoremap <tab>ih :history<CR>
nnoremap <tab>im :marks<CR>

" Select whole buffer without plugins
vnoremap ae <Esc>gg0vG$
" Not exact vie
vnoremap ie <Esc>gg}{vG{}k$
nnoremap yae mcggvG$y`c

" SETTINGS

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,noselect,preview
set complete=w,b,d,s,i,d,t

set noterse
set ruler
set number
set relativenumber

set ignorecase
set smartcase
set autoread
set noautochdir

set autoindent
set cindent
set expandtab
set shiftwidth=4
set tabstop=4

set linebreak
set nowrap
set breakindent
set showbreak=\\>>

set mouse=a
set notimeout
set ttimeout
set ttimeoutlen=100

" Neovim default setting at time of writing this
set backspace=indent,eol,start

" ???
" let &termencoding = &encoding
set termencoding=utf-8
set encoding=utf-8

set nomodeline
set modelines=10
