#!/usr/bin/env bash

__prompt_command() {
    # {{{
    # Because sometimes z.lua fucks up
    local EX="$?"
    if [ -n "$PS1_TIME" ]; then
        local DURATION=$(__calc_command_duration)
    fi
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    if [ -n "$PS1_USER" ]; then
        # PS1+="${MAGENTA}[${RESET}"
        PS1+="${CYAN}\u${RESET}"
        PS1+="${LRED}@${RESET}"
        PS1+="${LCYAN}\h${RESET} "
        # PS1+="${MAGENTA}]${RESET}"
        PS1+="${LBLUE}${RESET}"
    fi
    PS1+="${LMAGENTA}\w${RESET} "
    if [ -n "$PS1_TIME" ]; then
        PS1+="-> ${LWHITE}$DURATION${RESET}"
    fi
    if [ -n "$PS1_USER" ] || [ -n "$PS1_TIME" ]; then
        PS1+="\n"
    fi
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET}"
    PS1+="${LCYAN}$PSC ${RESET}"
} # }}}
