#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
[ -f "/etc/.aliasrc" ] && source "/etc/.aliasrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

#functions
[ -f "/etc/.funcrc" ] && source "/etc/.funcrc"
[ -f "$HOME/.funcrc" ] && source "$HOME/.funcrc"

#common variables
[ -f "/etc/.varrc" ] && source "/etc/.varrc"
[ -f "$HOME/.varrc" ] && source "$HOME/.varrc"

VISUAL="emacs -nw"
PS1='\[\033[34m\][ \[\033[1;34m\]\u\[\033[1;36m\]@\[\033[1;31m\]\h\[\033[0;34m\] ]\[\033[1;36m\]:\[\033[1;35m\]\w\[\033[1;33m\]$\[\033[0m\] '

source /home/michal/.config/broot/launcher/bash/br
