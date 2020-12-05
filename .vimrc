
" When started as "evim", evim.vim will already have done these settings, bail
" out.

if v:progname =~? "evim"
  finish
endif
if v:progname =~? "svim"
  syntax on
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

set wildmenu
set smartcase
set ignorecase

" hybrid line numbers
set number relativenumber
set nu rnu
