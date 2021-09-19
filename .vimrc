" When started as "evim", evim.vim will already have done these settings, bail
" out.

"if v:progname =~? "evim"
"  finish
"endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

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
nnoremap _e 0v$"cy:execute "!" . getreg("c")<CR>
nnoremap _d 0v$"cydd:execute "!" . getreg("c")<CR>
"nnoremap _w bvw"cy:execute "!" . getreg("c")<CR>

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
set smartcase
set ignorecase
set incsearch
filetype plugin on

" hybrid line numbers
set number relativenumber
set nu rnu

"if v:progname =~? "vim"
"  finish
"endif

call plug#begin('~/.vim/plugged')
 Plug 'mbbill/undotree'
 Plug 'junegunn/fzf'
 Plug 'unblevable/quick-scope'
 Plug 'jceb/vim-orgmode'
 Plug 'romainl/vim-cool'
" Plug 'easymotion/vim-easymotion'
 Plug 'justinmk/vim-sneak'
call plug#end()

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

silent! syntax on
silent! colorscheme darkblue
"torte
if v:progname =~? "gsvim" || v:progname =~? "gsview"
	silent! set guifont=-xos4-terminus-medium-r-normal--18-180-72-72-c-100-iso10646-1	
endif

silent! let s:lay="qwe"
silent! function! Wmt()
	if s:lay =~? "wkm"
		source .qwerty.vimrc
		let s:lay="qwe"
	else
		source .workman.vimrc
		let s:lay="wkm"
	endif
silent! endfunction

" Mapping motion in workman layout to be more
" 'normal' and cleaning keys messed in the process
" y n e o are h j k l
" and h j k l are e y n o
map <C-x> :call Wmt()<CR>
