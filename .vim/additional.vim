silent! source ~/.vim/vars.vim

nnoremap <Space><Space> :set hls!<CR>

set showcmd
set cursorline
set showmatch
set incsearch
set hlsearch

filetype plugin on
filetype indent on
syntax on

" Attempt to make vim easier to use
" in workman layout, with preserving
" logic (eg. d for delete, e for end...)
let s:lay="qwe"
function! Wmt()
	if s:lay =~? "wkm"
		source ~/.vim/qwerty.vim
		let s:lay="qwe"
	else
		source ~/.vim/workman.vim
		let s:lay="wkm"
	endif
endfunction

" Mapping motion in workman layout to be more
" 'normal' and cleaning keys messed in the process
" y n e o are h j k l
" and second time
" and h j k l are e y n o
map <C-s> :call Wmt()<CR>

"silent! source ~/.vim/colors.vim
"silent! source ~/.vim/syntax.vim
source ~/.vim/colors.vim
source ~/.vim/syntax.vim

let mapleader = ','
source ~/.vim/programming.vim
