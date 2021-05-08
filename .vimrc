
" When started as "evim", evim.vim will already have done these settings, bail
" out.

if v:progname =~? "evim"
  finish
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

"nnoremap tk  :tabfirst<CR>
"nnoremap tj  :tablast<CR>
"nnoremap tt  :tabedit<Space>
"nnoremap te  :tabedit<Space>
"nnoremap tm  :tabm<Space>
"nnoremap td  :tabclose<CR>
"nnoremap tn :tabnew<CR>
"nnoremap tl :tabnext<CR>
"nnoremap th :tabprev<CR>
"nnoremap tL :tabm +1<CR>
"nnoremap tH :tabm -1<CR>
"nnoremap tJ :tabm $<CR>
"nnoremap tK :tabm 0<CR>

tnoremap <C-w> <C-\><C-n>

map <C-y> "+gP
map <C-x>@hc :wqa<CR>
map <C-x>@hs :w<CR>
map <C-x>@ho :e
map <C-x>@h0 :q<CR>
map <C-x>@h2 :sp<CR>
map <C-x>@h3 :vs<CR>

nnoremap <C-x>@hh :wincmd h<CR>
nnoremap <C-x>@hj :wincmd j<CR>
nnoremap <C-x>@hk :wincmd k<CR>
nnoremap <C-x>@hl :wincmd l<CR>

nnoremap <C-x>@hH :wincmd H<CR>
nnoremap <C-x>@hJ :wincmd J<CR>
nnoremap <C-x>@hK :wincmd K<CR>
nnoremap <C-x>@hL :wincmd L<CR>

nnoremap <C-k>k  :tabfirst<CR>
nnoremap <C-k>j  :tablast<CR>
nnoremap <C-k>t  :tabedit<Space>
nnoremap <C-k>e  :tabedit<Space>
nnoremap <C-k>m  :tabm<Space>
nnoremap <C-k>d  :tabclose<CR>
nnoremap <C-k>n :tabnew<CR>
nnoremap <C-k>l :tabnext<CR>
nnoremap <C-k>h :tabprev<CR>
nnoremap <C-k>L :tabm +1<CR>
nnoremap <C-k>H :tabm -1<CR>
nnoremap <C-k>J :tabm $<CR>
nnoremap <C-k>K :tabm 0<CR>

"tnoremap <H-h> <C-w>h
"tnoremap <H-j> <C-w>j
"tnoremap <H-k> <C-w>k
"tnoremap <H-l> <C-w>l

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set smartcase
set ignorecase

" hybrid line numbers
set number relativenumber
set nu rnu

"if v:progname =~? "vim"
"  finish
"endif

silent! syntax on
silent! colorscheme darkblue
"torte
if v:progname =~? "gsvim" || v:progname =~? "gsview"
	silent! set guifont=-xos4-terminus-medium-r-normal--18-180-72-72-c-100-iso10646-1	
endif
