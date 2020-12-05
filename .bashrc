#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias nano='nano --rcfile=~/.nanorc'
alias ls='ls --color=always'
alias ll='ls -la'
alias nv=nvim
alias sv=svim
alias se=exs
alias em=emacs
alias sb=sbase-box
alias bb=busybox
PAGER=less
EDITOR=vim
VISUAL="emacs -nw"
QT_QPA_PLATFORMTHEME=qt5ct
PLAN9=/ext/plan9
QT_QPA_PLATFORM=xcb
PATH=$PATH:$PLAN9/bin
PATH=$PATH:/ext/eclipse/cpp

PS1='\[\033[34m\][ \[\033[1;34m\]\u\[\033[1;36m\]@\[\033[1;31m\]\h\[\033[0;34m\] ]\[\033[1;36m\]:\[\033[1;35m\]\w\[\033[1;32m\]$\[\033[0m\] '
#\[\033[1;32;40m\]\h\[\033[0;37;40m\]:\[\033[34;40m\][\[\033[1;31;40m\]\u\[\033[0;34;40m\]]\[\033[0;37;40m\]:\[\033[35;40m\]\w\[\033[1;33;40m\]#\[\033[0m\]
