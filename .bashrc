#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

conditional_source () {
	[ -f "$1" ] && source "$1"
}

#aliases
conditional_source "/etc/.aliasrc"
conditional_source "$HOME/.aliasrc"

#functions
conditional_source "/etc/.funcrc"
conditional_source "$HOME/.funcrc"

#common variables
conditional_source "/etc/.varrc"
conditional_source "$HOME/.varrc"

#VISUAL="emacs -nw"
PS1='\[\033[34m\][ \[\033[1;34m\]\u\[\033[1;36m\]@\[\033[1;31m\]\h\[\033[0;34m\] ]\[\033[1;36m\]:\[\033[1;35m\]\w\[\033[1;33m\]$\[\033[0m\] '

eval "$(direnv hook bash)" 2>/dev/null
