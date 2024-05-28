silent! source ~/.vim/vars.vim
source ~/.vim/functions.vim
source ~/.vim/keys.vim
source ~/.vim/files.vim

set nocompatible
set termguicolors
set showcmd
set showmatch
set incsearch
set hlsearch

filetype plugin on
filetype indent on
syntax on
syntax reset

packadd! matchit
runtime macros/matchit.vim
runtime! ftplugin/man.vim

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
