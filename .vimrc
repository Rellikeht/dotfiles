source ~/.vim/tiny-compatible.vim

" Configration suited for beeing shared between neovim (nvim), custom compiled 
" vim / standard vim from repos (vim) and vim-tiny (tvim / vi)

if v:progname !~? "tv\\?\\(im\\?\\)\\?"
    " and it works, at least now
    source ~/.vim/additional.vim

    let plug_src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let g:data_dir = has('nvim') ? stdpath('config') : '~/.vim'
    if empty(glob(g:data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.g:data_dir.
                    \'/autoload/plug.vim --create-dirs '.plug_src
        autocmd VimEnter * 
                    \ PlugInstall --sync | source $MYVIMRC
    endif

    if v:progname =~? "^s\\?v\\(im\\?\\)\\?"
        call plug#begin('~/.vim/plugged')
        source ~/.vim/preplug.vim
        source ~/.vim/svimrc.vim
        source ~/.vim/common-plugins.vim
        source ~/.vim/svim-plugins.vim

        call plug#end()
        source ~/.vim/svim-plug-handlers.vim
    endif

    source ~/.vim/plug-handlers.vim
    source ~/.vim/programming.vim
    source ~/.vim/colors.vim
endif

silent! source ~/.vimrc.local
