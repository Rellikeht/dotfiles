
" When started as "evim", evim.vim will already have done these settings, bail
" out.

if v:progname =~? "evim"
  finish
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

nnoremap tk  :tabfirst<CR>
nnoremap tj  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap te  :tabedit<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap tn :tabnew<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tL :tabm +1<CR>
nnoremap tH :tabm -1<CR>
nnoremap tJ :tabm $<CR>
nnoremap tK :tabm 0<CR>

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
