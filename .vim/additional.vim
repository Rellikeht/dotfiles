"{{{ settings

set nocompatible
set termguicolors
set foldmethod=marker

"}}}

"{{{ plugins and packages

filetype plugin on
filetype indent on
syntax on
syntax reset

packadd! matchit
runtime macros/matchit.vim
runtime! ftplugin/man.vim

"}}}

"{{{ sourcing

silent! source ~/.vim/vars.vim
source ~/.vim/functions.vim
source ~/.vim/settings.vim
source ~/.vim/keys.vim
source ~/.vim/files.vim
source ~/.vim/syntax.vim
source ~/.vim/ssh.vim

"}}}

" ??
if has('win32')
"{{{

    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag='-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote=''
    let &shellpipe='| Out-File -Encoding UTF8 %s'
    let &shellredir='| Out-File -Encoding UTF8 %s'

"}}}
endif
