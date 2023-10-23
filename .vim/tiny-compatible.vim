" KEYS

map <Space> <C-w>
map gY "+gP

map gb <C-]>
map gB <C-t>

" TODO this is harder than it should
map g+ v<C-a>
map g- v<C-x>
vmap + <C-a>
vmap - <C-x>

" Amateur but works
map zS :sleep <CR>

"" This is alt, but should be altgr
"map <A-s> <A-s><A-s>
"map <A-s> :q!<CR>
"imap <a-s> :q!<CR>
"imap <m-s> :q!<CR>

"" Hyper modifier from emacs
"" working in console (even
"" bindings are similar):
"map <C-x>@hc :wqa<CR>
"map <C-x>@hs :w<CR>
"map <C-x>@ho :e
"map <C-x>@h0 :q<CR>
"map <C-x>@h2 :sp<CR>
"map <C-x>@h3 :vs<CR>
"
"" Those are not
"nnoremap <C-x>@hh :wincmd h<CR>
"nnoremap <C-x>@hj :wincmd j<CR>
"nnoremap <C-x>@hk :wincmd k<CR>
"nnoremap <C-x>@hl :wincmd l<CR>
"
"nnoremap <C-x>@hH :wincmd H<CR>
"nnoremap <C-x>@hJ :wincmd J<CR>
"nnoremap <C-x>@hK :wincmd K<CR>
"nnoremap <C-x>@hL :wincmd L<CR>

" Tabs with <Tab>
nmap <Tab>k :tabfirst<CR>
nmap <Tab>j :tablast<CR>
nmap <Tab>l gt
nmap <Tab>h gT
nmap <Tab>t :tabedit<Space>
nmap <Tab>m :tabm<Space>
nmap <Tab>d :tabclose<CR>
nmap <Tab>T :tabnew<CR>
nmap <Tab>L :tabm +1<CR>
nmap <Tab>H :tabm -1<CR>
nmap <Tab>J :tabm $<CR>
nmap <Tab>K :tabm 0<CR>
nmap <Tab>B :tabnew<CR>:buffer<Space>
nmap <Tab><Tab> g<Tab>
nmap <Tab>i :tabs<CR>

" Buffers with <Tab>
nmap <Tab>b :buffer<Space>
nmap <Tab>n :bnext<CR>
nmap <Tab>p :bprevious<CR>
nmap <Tab>N :bnext!<CR>
nmap <Tab>P :bprevious!<CR>
nmap <Tab>D :bdelete<CR>
nmap <Tab>U :bunload<CR>
nmap <Tab>s :sbprevious<CR>
nmap <Tab>S :sbnext<CR>
nmap <Tab>v :vsplit<CR>:bnext<CR>
nmap <Tab>V :vsplit<CR>:bprevious<CR>
nmap <Tab>a :bad<Space>
"nmap <Tab>A :balt<Space>
nmap <Tab>f :files<CR>
nmap <Tab>c :bmodified<CR>
nmap <Tab>C :bmodified!<CR>
nmap <Tab>g :vsplit<Space>
nmap <Tab>G :split<Space>
nmap <Tab>I :buffers<CR>

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
"set noexpandtab
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
