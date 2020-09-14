#
# ~/.mkshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias nano='nano --rcfile=~/.nanorc'
alias ls='ls --color'
alias ll='ls -la'
HISTFILE=~/.ksh_history
PAGER=less
EDITOR=nano
VISUAL="emacs -nw"
QT_QPA_PLATFORMTHEME=qt5ct
PLAN9=/ext/plan9
PATH=$PATH:$PLAN9/bin
PATH="$PATH:/home/michal/.komodoide/12.0/XRE/state" # ActiveState State Tool
PS1=$'\e[1;34m< \e[32m$USER\e[35m@\e[1;31m${HOSTNAME:=$(hostname)}\e[00m : \e[1;36m$PWD\e[00m \e[1;34m>$ \e[00m'
PS2=$'\e[1;34m$> \e[00m'
PS3=$'\e[35m?> \e[00m'
PS4=$'\e[32m$+> \e[00m'
