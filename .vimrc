source ~/.vim/tiny-compatible.vim

" I have probably the most minimalistic vim possible
" from Herecura unofficial Arch repository (vim-tiny package),
" vim compiled with only features i need (binary is
" called svim for distinction) and neovim (also from repos)
" as small ide. This config is read by all of them, because
" some parts are common, so i needed to do this:

if v:progname !~? "^vi"
    " and it works, at least now
    source ~/.vim/additional.vim
    if v:progname =~? ".*svi.*"
	    call plug#begin('~/.vim/plugged')
		source ~/.vim/common-plugins.vim
	    call plug#end()
	    source ~/.vim/svim-plug-handlers.vim
    endif
    source ~/.vim/plug-handlers.vim
endif

silent! source ~/.vimrc.local
