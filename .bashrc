#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias nano='nano --rcfile=~/.nanorc'
alias ls='ls --color=always'
alias ll='ls -la'
PS1='[\u@\h \W]\$ '
PAGER=less
EDITOR=nano
QT_QPA_PLATFORMTHEME=qt5ct

export PATH="$PATH:/home/michal/.komodoide/12.0/XRE/state" # ActiveState State Tool
