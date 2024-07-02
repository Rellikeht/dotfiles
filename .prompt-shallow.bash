#!/usr/bin/env bash
# TODO

__prompt_command() {
    # {{{

    # this has to be first
    local EXIT="$?"
    PS1=""

    # {{{ colors
    local RESET='\[\e[0m\]'

    local BLACK='\[\e[0;30m\]'
    local RED='\[\e[0;31m\]'
    local GREEN='\[\e[0;32m\]'
    local YELLOW='\[\e[0;33m\]'
    local BLUE='\[\e[0;34m\]'
    local MAGENTA='\[\e[0;35m\]'
    local CYAN='\[\e[0;36m\]'
    local WHITE='\[\e[0;37m\]'

    local LBLACK='\[\e[1;30m\]'
    local LRED='\[\e[1;31m\]'
    local LGREEN='\[\e[1;32m\]'
    local LYELLOW='\[\e[1;33m\]'
    local LBLUE='\[\e[1;34m\]'
    local LMAGENTA='\[\e[1;35m\]'
    local LCYAN='\[\e[1;36m\]'
    local LWHITE='\[\e[1;37m\]'
    # }}}

    PS1+="${MAGENTA}[ ${RESET}"
    PS1+="${CYANj}\u${RESET}"
    PS1+="${LRED}@${RESET}"
    PS1+="${LCYAN}\h${RESET}"
    PS1+="${MAGENTA} ]${RESET}"
    PS1+="${LBLUE}:${RESET}"
    PS1+="${LMAGENTA}\w${RESET}"

    if [ $EXIT != 0 ]; then
        PS1+="${RED}"
    else
        PS1+="${GREEN}"
    fi

    PS1+="[$EXIT]${RESET}"
    PS1+="${LCYAN}$PSC ${RESET}"
}
# }}}
