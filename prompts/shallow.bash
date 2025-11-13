#!/usr/bin/env bash

__prompt_command() {
    # {{{
    # Because sometimes z.lua fucks up
    local EX="$?"
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi

    PS1=""
    if [ -n "$PS1_USER" ]; then
        # PS1+="${MAGENTA}[${RESET}"
        PS1+="${MAGENTA}\u${RESET}"
        PS1+="${LRED}@${RESET}"
        PS1+="${LMAGENTA}\h${RESET} "
        # PS1+="${MAGENTA}]${RESET}"
        PS1+="${LBLUE}${RESET}"
    fi
    PS1+="${GREEN}\w${RESET} "

    if [ -n "$PS1_USER" ]; then
        PS1+="\n"
    fi
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi

    PS1+="[$EX]${RESET}"
    PS1+="${LMAGENTA}$PSC ${RESET}"
} # }}}
