" KEYS

map <Space> <C-w>
map <Space><Space> <C-w><C-w>

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

" Windows
" TODO more

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

" What happens here
set wildchar=<Tab>
set wildmode=list:full
set wildoptions=fuzzy,tagfile,pum
set wildmenu

set completeopt=menu,menuone,noselect,noinsert,preview
set complete=w,b,d,s,i,d,t,.,k

set noterse
set ruler
set number
set relativenumber

set ignorecase
set smartcase
set noautochdir
set autoread

set formatoptions=tcroqlwn
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

set termencoding=utf-8
set encoding=utf-8

set nomodeline
set modelines=5

if v:progname =~? "^tv\\(im\\?\\)\\?"
    set background=dark
endif
