#
# ~/.kshrc
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

HISTFILE=~/.ksh_history
VISUAL="nvim"
PS1=$'\e[1;34m< \e[32m$USER\e[35m@\e[1;31m${HOSTNAME:=$(hostname)}\e[00m : \e[1;36m$PWD\e[00m \e[1;34m>$ \e[00m'
PS2=$'\e[1;34m$> \e[00m'
PS3=$'\e[35m?> \e[00m'
PS4=$'\e[32m$+> \e[00m'
