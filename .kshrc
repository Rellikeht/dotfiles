#
# ~/.kshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

#common variables
[ -f "$HOME/.varrc" ] && source "$HOME/.varrc"

HISTFILE=~/.ksh_history
VISUAL="nvim"
PS1=$'\e[1;34m< \e[32m$USER\e[35m@\e[1;31m${HOSTNAME:=$(hostname)}\e[00m : \e[1;36m$PWD\e[00m \e[1;34m>$ \e[00m'
PS2=$'\e[1;34m$> \e[00m'
PS3=$'\e[35m?> \e[00m'
PS4=$'\e[32m$+> \e[00m'
