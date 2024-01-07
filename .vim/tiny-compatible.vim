" KEYS

map <Space> <C-w>
map gY "+gP

map gb <C-]>
map gB <C-t>

" TODO this is harder than it should be
map g+ v<C-a>
map g- v<C-x>
vmap + <C-a>
vmap - <C-x>

" Tabs with <Tab>
map <Tab>k :tabfirst<CR>
map <Tab>j :tablast<CR>
map <Tab>l gt
map <Tab>h gT
map <Tab>t :tabedit<Space>
map <Tab>m :tabm<Space>
map <Tab>d :tabclose<CR>
map <Tab>T :tabnew<CR>
map <Tab>L :tabm +1<CR>
map <Tab>H :tabm -1<CR>
map <Tab>J :tabm $<CR>
map <Tab>K :tabm 0<CR>
map <Tab>B :tabnew<CR>:buffer<Space>
map <Tab><Tab> g<Tab>
map <Tab>i :tabs<CR>

" Buffers with <Tab>
map <Tab>b :buffer<Space>
map <Tab>n :bnext<CR>
map <Tab>p :bprevious<CR>
map <Tab>N :bnext!<CR>
map <Tab>P :bprevious!<CR>
map <Tab>D :bdelete<CR>
map <Tab>U :bunload<CR>
map <Tab>s :sbprevious<CR>
map <Tab>S :sbnext<CR>
map <Tab>v :vsplit<CR>:bnext<CR>
map <Tab>V :vsplit<CR>:bprevious<CR>
map <Tab>a :bad<Space>
"map <Tab>A :balt<Space>
map <Tab>f :files<CR>
map <Tab>c :bmodified<CR>
map <Tab>C :bmodified!<CR>
map <Tab>g :vsplit<Space>
map <Tab>G :split<Space>
map <Tab>I :buffers<CR>

" Others
map <Tab>W :set wrap!<CR>
map <Tab>o :source %<CR>

" Select whole buffer without plugins
vmap ae <Esc>gg0vG$
" Not exact vie
vmap ie <Esc>gg}{vG{}k$
"vae defined earlier doesn't work here
nmap yae mcggvG$y`c

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
set nowrap

set mouse=a
set notimeout
set ttimeout
set ttimeoutlen=100

" Neovim default setting at time of writing this
set backspace=indent,eol,start

set modeline
set modelines=10
