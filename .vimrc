source ~/.vim/tiny-compatible.vim

" Configration suited for beeing shared between neovim (nvim), custom compiled 
" vim / standard vim from repos (vim) and vim-tiny (tvim / vi)

if v:progname !~? "t\\(v\\(im\\)\\?\\)\\?"
  " and it works, at least now

  " plugins and packages {{{ 
  " vim-plug does it
  " filetype plugin on
  " filetype indent on
  " syntax on

  packadd! cfilter
  if !has("nvim")
    runtime! ftplugin/man.vim
  endif

  " because of matchup
  " packadd! matchit
  " runtime macros/matchit.vim
  " }}} 

  " sourcing {{{ 

  silent! source ~/.vim/vars.vim
  source ~/.vim/functions.vim
  source ~/.vim/settings.vim
  source ~/.vim/keys.vim
  source ~/.vim/files.vim

  " }}} 

  if has('win32') " ?? {{{ 
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag='-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote=''
    let &shellpipe='| Out-File -Encoding UTF8 %s'
    let &shellredir='| Out-File -Encoding UTF8 %s'
  endif " }}} 

  " vim plug auto install {{{ 
  let plug_src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let g:data_dir = has('nvim') ? stdpath('config') : '~/.vim'
  if empty(glob(g:data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.g:data_dir.
          \'/autoload/plug.vim --create-dirs '.plug_src
    autocmd VimEnter * 
          \ PlugInstall --sync | source $MYVIMRC
  endif
  " }}} 

  for f in split(glob("~/.vim/preplug/*.vim"), "\n")
    exe "source ".fnameescape(f)
  endfor

  if v:progname =~? "^s\\?v\\(im\\)\\?" " {{{ 
    source ~/.vim/svimrc.vim
    call plug#begin('~/.vim/plugged')
    source ~/.vim/common-plugins.vim
    source ~/.vim/svim-plugins.vim
    call plug#end()
    source ~/.vim/svim-plug-handlers.vim
  endif " }}} 

  " Those (may) use plugins, but aren't for plugins setup
  source ~/.vim/quickstack.vim
  " source ~/.vim/arglists.vim
  source ~/.vim/programming.vim
  source ~/.vim/look.vim

  if filereadable(expand('~/.local.vimrc'))
    source ~/.local.vimrc
  endif
endif
