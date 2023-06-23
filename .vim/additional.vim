silent! source ~/.vim/vars.vim
source ~/.vim/functions.vim
source ~/.vim/keys.vim

set termguicolors
set showcmd
set showmatch
set incsearch
set hlsearch
"set cursorline

filetype plugin on
filetype indent on
syntax on
syntax reset

"source ~/.vim/colors.vim

" TODO C better colors
if v:progname =~? ".*svi.*"
	colorscheme default
endif
set background=light " dark

source ~/.vim/syntax.vim
source ~/.vim/programming.vim
