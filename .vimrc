source ~/.vim/tiny-compatible.vim

" I have probably the most minimalistic vim possible
" from Herecura unofficial Arch repository (vim-tiny package),
" vim compiled with only features i need (binary is
" called svim for distinction) and neovim (also from repos)
" as small ide. This config is read by all of them, because
" some parts are common, so i needed to do this:

if v:progname !~? "^vi"
    let plug_src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    " and it works, at least now
    source ~/.vim/additional.vim

    " let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    let data_dir = '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.
                    \'/autoload/plug.vim --create-dirs '.plug_src
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    if v:progname =~? ".*svi.*"
        call plug#begin('~/.vim/plugged')
        source ~/.vim/common-plugins.vim
        source ~/.vim/svim-plugins.vim

        call plug#end()
        source ~/.vim/svim-plug-handlers.vim
    endif
    source ~/.vim/plug-handlers.vim
endif

silent! source ~/.vimrc.local
