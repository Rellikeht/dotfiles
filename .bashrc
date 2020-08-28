#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias nano='nano --rcfile=~/.nanorc'
#alias ls='ls --color=always'
alias ll='ls -la'
#PS1='[\u@\h \W]\$ '
PAGER=less
EDITOR=nano
#QT_QPA_PLATFORMTHEME=qt5ct
PLAN9=/ext/plan9
PATH=$PATH:$PLAN9/bin

export PATH="$PATH:/home/michal/.komodoide/12.0/XRE/state" # ActiveState State Tool
PS1='\[\033[34;40m\][ \[\033[1;32;40m\]\u\[\033[1;33;40m\]@\[\033[1;31;40m\]\h\[\033[0;34;40m\] ]\[\033[0;37;40m\]:\[\033[35;40m\]\w\[\033[1;33;40m\]$\[\033[0m\] '
#\[\033[1;32;40m\]\h\[\033[0;37;40m\]:\[\033[34;40m\][\[\033[1;31;40m\]\u\[\033[0;34;40m\]]\[\033[0;37;40m\]:\[\033[35;40m\]\w\[\033[1;33;40m\]#\[\033[0m\]
