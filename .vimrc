source ~/.vim/tiny-compatible.vim

" Configration suited for beeing shared between neovim (nvim), custom compiled 
" vim / standard vim from repos (vim) and vim-tiny (tvim / vi)

if v:progname !~? "tv\\?\\(im\\?\\)\\?"
  " and it works, at least now

  "{{{ plugins and packages
  filetype plugin on
  filetype indent on

  packadd! matchit
  packadd! cfilter

  runtime macros/matchit.vim
  runtime! ftplugin/man.vim
  "}}}

  "{{{ sourcing
  silent! source ~/.vim/vars.vim
  source ~/.vim/functions.vim
  source ~/.vim/settings.vim
  source ~/.vim/arglists.vim
  source ~/.vim/keys.vim
  source ~/.vim/quickstack.vim
  source ~/.vim/files.vim
  source ~/.vim/syntax.vim
  source ~/.vim/ssh.vim
  source ~/.vim/history.vim
  "}}}

  if has('win32') "{{{ ??
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag='-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote=''
    let &shellpipe='| Out-File -Encoding UTF8 %s'
    let &shellredir='| Out-File -Encoding UTF8 %s'
  endif "}}}

  "{{{ vim plug auto install
  let plug_src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let g:data_dir = has('nvim') ? stdpath('config') : '~/.vim'
  if empty(glob(g:data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.g:data_dir.
          \'/autoload/plug.vim --create-dirs '.plug_src
    autocmd VimEnter * 
          \ PlugInstall --sync | source $MYVIMRC
  endif
  "}}}

  if v:progname =~? "^s\\?v\\(im\\?\\)\\?" "{{{
    source ~/.vim/preplug.vim
    source ~/.vim/svimrc.vim
    call plug#begin('~/.vim/plugged')
    source ~/.vim/common-plugins.vim
    source ~/.vim/svim-plugins.vim
    call plug#end()
    source ~/.vim/svim-plug-handlers.vim
  endif "}}}

  "{{{ additional sourcing
  for f in split(glob("~/.vim/plug-handlers/*.vim"), "\n")
    exe 'source '.fnameescape(f)
  endfor

  source ~/.vim/programming.vim
  source ~/.vim/look.vim
  "}}}

endif

silent! source ~/.vimrc.local
