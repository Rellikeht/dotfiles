#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
PAGER=less
EDITOR=vim

export PATH="$PATH:/home/michal/.komodoide/12.0/XRE/state" # ActiveState State Tool
