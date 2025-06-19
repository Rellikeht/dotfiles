#!/usr/bin/env bash

__prompt_command() {
    # {{{
    local EX="$?"
    if [ -n "$EXIT" ]; then
        EX="$EXIT"
    fi
    PS1=""
    PS1+="${LCYAN}\w${RESET} "
    if [ "$EX" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi
    PS1+="[$EX]${RESET}"
    PS1+="${LYELLOW}$PSC${RESET} "
} # }}}
