" KEYS

map <Space> <C-w>
map gY "+gP

map gb <C-]>
map gB <C-t>

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

" Tabs with ;
nmap ;k :tabfirst<CR>
nmap ;j :tablast<CR>
nmap ;l gt
nmap ;h gT
nmap ;t :tabedit<Space>
nmap ;m :tabm<Space>
nmap ;d :tabclose<CR>
nmap ;T :tabnew<CR>
nmap ;L :tabm +1<CR>
nmap ;H :tabm -1<CR>
nmap ;J :tabm $<CR>
nmap ;K :tabm 0<CR>
nmap ;B :tabnew<CR>:buffer<Space>
nmap ;<Tab> g<Tab>
nmap ;i :tabs<CR>

" Buffers with ;
nmap ;b :buffer<Space>
nmap ;n :bnext<CR>
nmap ;p :bprevious<CR>
nmap ;N :bnext!<CR>
nmap ;P :bprevious!<CR>
nmap ;D :bdelete<CR>
nmap ;U :bunload<CR>
nmap ;s :sbprevious<CR>
nmap ;S :sbnext<CR>
nmap ;v :vsplit<CR>:bnext<CR>
nmap ;V :vsplit<CR>:bprevious<CR>
nmap ;a :bad<Space>
"nmap ;A :balt<Space>
nmap ;f :files<CR>
nmap ;c :bmodified<CR>
nmap ;C :bmodified!<CR>
nmap ;g :vsplit<Space>
nmap ;G :split<Space>
nmap ;I :buffers<CR>

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
