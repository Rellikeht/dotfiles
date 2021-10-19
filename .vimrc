tnoremap <C-w> <C-\><C-n>
map <C-y> "+gP

" Hyper modifier from emacs
" working in console (even
" bindings are similar):
map <C-x>@hc :wqa<CR>
map <C-x>@hs :w<CR>
map <C-x>@ho :e
map <C-x>@h0 :q<CR>
map <C-x>@h2 :sp<CR>
map <C-x>@h3 :vs<CR>

" Those are not
nnoremap <C-x>@hh :wincmd h<CR>
nnoremap <C-x>@hj :wincmd j<CR>
nnoremap <C-x>@hk :wincmd k<CR>
nnoremap <C-x>@hl :wincmd l<CR>

nnoremap <C-x>@hH :wincmd H<CR>
nnoremap <C-x>@hJ :wincmd J<CR>
nnoremap <C-x>@hK :wincmd K<CR>
nnoremap <C-x>@hL :wincmd L<CR>

"" tabs with unused <C-k>
"nnoremap <C-k>k  :tabfirst<CR>
"nnoremap <C-k>j  :tablast<CR>
"nnoremap <C-k>t  :tabedit<Space>
"nnoremap <C-k>e  :tabedit<Space>
"nnoremap <C-k>m  :tabm<Space>
"nnoremap <C-k>d  :tabclose<CR>
"nnoremap <C-k>n :tabnew<CR>
"nnoremap <C-k>l :tabnext<CR>
"nnoremap <C-k>h :tabprev<CR>
"nnoremap <C-k>L :tabm +1<CR>
"nnoremap <C-k>H :tabm -1<CR>
"nnoremap <C-k>J :tabm $<CR>
"nnoremap <C-k>K :tabm 0<CR>
"
"" buffers
"nnoremap <C-k>a  :bnext<CR>
"nnoremap <C-k>d  :bprevious<CR>
"nnoremap <C-k>R  :bdelete<CR>
"nnoremap <C-k>u  :buffers<CR>
"nnoremap <C-k>Q  :bunload<CR>

" tabs with unused _
nnoremap _k :tabfirst<CR>
nnoremap _j :tablast<CR>
nnoremap _l :tabnext<CR>
nnoremap _h :tabprev<CR>
nnoremap _t :tabedit<Space>
"nnoremap _e :tabedit<Space>
nnoremap _m :tabm<Space>
nnoremap _d :tabclose<CR>
nnoremap _T :tabnew<CR>
nnoremap _L :tabm +1<CR>
nnoremap _H :tabm -1<CR>
nnoremap _J :tabm $<CR>
nnoremap _K :tabm 0<CR>
nnoremap _B :tabnew<CR>:buffer<Space>

" buffers
nnoremap _b :buffer<Space>
nnoremap _n :bnext<CR>
nnoremap _p :bprevious<CR>
nnoremap _N :bnext!<CR>
nnoremap _P :bprevious!<CR>
nnoremap _D :bdelete<CR>
nnoremap _U :bunload<CR>
nnoremap _s :sbprevious<CR>
nnoremap _S :sbnext<CR>
nnoremap _v :vsplit<CR>:bnext<CR>
nnoremap _V :vsplit<CR>:bprevious<CR>
nnoremap _a :bad<Space>
"nnoremap _A :balt<Space>
nnoremap _f :files<CR>
nnoremap _c :bmodified<CR>
nnoremap _C :bmodified!<CR>

" emacs style C-k C-
"nnoremap <C-k><C-k>  :tabfirst<CR>
"nnoremap <C-k><C-j>  :tablast<CR>
"nnoremap <C-k><C-t>  :tabedit<Space>
"nnoremap <C-k><C-e>  :tabedit<Space>
"nnoremap <C-k><C-m>  :tabm<Space>
"nnoremap <C-k><C-d>  :tabclose<CR>
"nnoremap <C-k><C-n> :tabnew<CR>
"nnoremap <C-k><C-l> :tabnext<CR>
"nnoremap <C-k><C-h> :tabprev<CR>
"nnoremap <C-k><C-L> :tabm +1<CR>
"nnoremap <C-k><C-H> :tabm -1<CR>
"nnoremap <C-k><C-J> :tabm $<CR>
"nnoremap <C-k><C-K> :tabm 0<CR>

nnoremap \e 0v$"cy:execute "!" . getreg("c")<CR>
nnoremap \d 0v$"cydd:execute "!" . getreg("c")<CR>
"nnoremap \w bvw"cy:execute "!" . getreg("c")<CR>

" Select whole buffer without plugins
vnoremap ae <Esc>ggvG$
" Not exact vie
vnoremap ie <Esc>gg}{vG{}k$
"vae defined earlier doesn't work here
nnoremap yae mcggvG$y'c

filetype plugin on
filetype indent on

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set showcmd
set cursorline

" hybrid line numbers, my favourite
set number relativenumber
set nu rnu
set ruler

" searching
set ignorecase
set smartcase
set showmatch
set hlsearch
set incsearch
nnoremap <Space> :set hls!<CR>
nnoremap <CR> :set hls!<CR>

" For motif gui to work with accented letters
if v:progname =~? "gsvim" || v:progname =~? "gsview"
	silent! set guifont=-xos4-terminus-medium-r-normal--18-180-72-72-c-100-iso10646-1	
endif

if v:progname !=? "vim"
	silent! syntax on
	silent! colorscheme darkblue
	"desert/slate

	" Attempt to make vim easier to use
	" in workman layout, with preserving
	" logic (eg. d for delete, e for end...)
	let s:lay="qwe"
	function! Wmt()
		if s:lay =~? "wkm"
			source .qwerty.vimrc
			let s:lay="qwe"
		else
			source .workman.vimrc
			let s:lay="wkm"
		endif
	endfunction

	" Mapping motion in workman layout to be more
	" 'normal' and cleaning keys messed in the process
	" y n e o are h j k l
	" and second time
	" and h j k l are e y n o
	map <C-s> :call Wmt()<CR>
	
	call plug#begin('~/.vim/plugged')
	 Plug 'mbbill/undotree'
	 Plug 'junegunn/fzf'
	 Plug 'unblevable/quick-scope'
	 Plug 'jceb/vim-orgmode'
	 "saddly has problems
	 "Plug 'easymotion/vim-easymotion'
	 Plug 'justinmk/vim-sneak'
	call plug#end()

	let g:qs_delay = 100

	"let mapleader = ','
	"" <Leader>f{char} to move to {char}
	"map  <Leader>f <Plug>(easymotion-bd-f)
	"nmap <Leader>f <Plug>(easymotion-overwin-f)
	"
	"" s{char}{char} to move to {char}{char}
	"nmap s <Plug>(easymotion-overwin-f2)
	"
	"" Move to line
	"map <Leader>l <Plug>(easymotion-bd-jk)
	"nmap <Leader>l <Plug>(easymotion-overwin-line)
	"
	"" Move to word
	"map  <Leader>w <Plug>(easymotion-bd-w)
	"nmap <Leader>w <Plug>(easymotion-overwin-w)

endif
