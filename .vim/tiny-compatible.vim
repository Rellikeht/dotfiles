" KEYS

map <Space> <C-w>
map gY "+gP

map gb <C-]>
map gB <C-t>

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

" Tabs with _
nmap _k :tabfirst<CR>
nmap _j :tablast<CR>
nmap _l gt
nmap _h gT
nmap _t :tabedit<Space>
nmap _m :tabm<Space>
nmap _d :tabclose<CR>
nmap _T :tabnew<CR>
nmap _L :tabm +1<CR>
nmap _H :tabm -1<CR>
nmap _J :tabm $<CR>
nmap _K :tabm 0<CR>
nmap _B :tabnew<CR>:buffer<Space>
nmap _<Tab> g<Tab>
nmap _i :tabs<CR>

" Buffers with _
nmap _b :buffer<Space>
nmap _n :bnext<CR>
nmap _p :bprevious<CR>
nmap _N :bnext!<CR>
nmap _P :bprevious!<CR>
nmap _D :bdelete<CR>
nmap _U :bunload<CR>
nmap _s :sbprevious<CR>
nmap _S :sbnext<CR>
nmap _v :vsplit<CR>:bnext<CR>
nmap _V :vsplit<CR>:bprevious<CR>
nmap _a :bad<Space>
"nmap _A :balt<Space>
nmap _f :files<CR>
nmap _c :bmodified<CR>
nmap _C :bmodified!<CR>
nmap _g :vsplit<Space>
nmap _G :split<Space>
nmap _I :buffers<CR>

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
