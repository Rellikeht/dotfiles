silent! source ~/.vim/vars.vim
source ~/.vim/functions.vim
source ~/.vim/keys.vim

set termguicolors
set showcmd
set showmatch
set incsearch
set hlsearch

" TODO B what this does
packadd matchit

filetype plugin on
filetype indent on
syntax on
syntax reset

if v:progname =~? ".*svi.*"
    colorscheme default
endif
set background=light " dark

set foldmethod=marker

source ~/.vim/syntax.vim

if has('win32')
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag='-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote=''
    let &shellpipe='| Out-File -Encoding UTF8 %s'
    let &shellredir='| Out-File -Encoding UTF8 %s'
endif
