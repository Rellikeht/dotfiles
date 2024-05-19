" KEYS

noremap <Space> <C-w>
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
noremap <Tab>m :tabm<Space>
noremap <silent> <Tab>d :tabclose<CR>
noremap <silent> <Tab>T :tabnew<CR>
noremap <silent> <Tab>L :tabm +1<CR>
noremap <silent> <Tab>H :tabm -1<CR>
noremap <silent> <Tab>J :tabm $<CR>
noremap <silent> <Tab>K :tabm 0<CR>
noremap <Tab>e :tab<Space>sb<Space>
noremap <Tab><Tab> :tab<Space>
noremap <Tab><CR> :-tab<Space>
noremap <silent> <Tab>i :tabs<CR>

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
noremap <Tab>a :bad<Space>
"noremap <Tab>A :balt<Space>
noremap <silent> <Tab>f :files<CR>
noremap <silent> <Tab>c :bmodified<CR>
noremap <silent> <Tab>C :bmodified!<CR>
noremap <Tab>g :vsplit<Space>
noremap <Tab>G :split<Space>
noremap <silent> <Tab>I :buffers<CR>

" Others
noremap <Tab>W :set wrap!<CR>
noremap <Tab>Q :source %<CR>
noremap <Tab>M :setlocal modeline!<CR>
noremap <Tab>E :e<CR>

" Select whole buffer without plugins
vnoremap ae <Esc>gg0vG$
" Not exact vie
vnoremap ie <Esc>gg}{vG{}k$
nnoremap yae mcggvG$y`c

" SETTINGS

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,preview,menuone,noselect

set noterse
set ruler
set number
set relativenumber

set ignorecase
set smartcase
set autoread

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

set nomodeline
set modelines=10
