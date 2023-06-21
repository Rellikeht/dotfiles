silent! source ~/.vim/vars.vim
source ~/.vim/functions.vim
source ~/.vim/keys.vim

set showcmd
set cursorline
set showmatch
set incsearch
set hlsearch

filetype plugin on
filetype indent on
syntax on
syntax reset

"source ~/.vim/colors.vim

" TODO better colors
" TODO B
set background=dark
if v:progname =~? ".*svi.*"
	colorscheme default
endif

source ~/.vim/syntax.vim
source ~/.vim/programming.vim
