# vim: set syn=bash ft=bash:
#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#VISUAL="emacs -nw"
PS1='\[\033[34m\][ \[\033[1;34m\]\u\[\033[1;36m\]@\[\033[1;31m\]\h\[\033[0;34m\] ]\[\033[1;36m\]:\[\033[1;35m\]\w\[\033[1;33m\]$\[\033[0m\] '

source ~/.commonrc
eval "$(direnv hook bash)" 2>/dev/null
