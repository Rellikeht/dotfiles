#!/usr/bin/env bash

if [ "$TIME_PS1" == "0" ]; then
    TIME_PS1=
else
    TIME_PS1=1
fi

__prompt_command() {
    # {{{
    local EX="$?"
    if [ -n "$TIME_PS1" ]; then
        local DURATION=$(__calc_command_duration)
    fi
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    PS1+="${LBLUE}${SHLVL}=${RESET} "
    PS1+="${LMAGENTA}\w${RESET} "
    if [ -n "$TIME_PS1" ]; then
        PS1+="-> ${LWHITE}$DURATION${RESET}"
        PS1+="\n"
    fi
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET}"
    PS1+="${LYELLOW}$PSC${RESET} "
} # }}}
