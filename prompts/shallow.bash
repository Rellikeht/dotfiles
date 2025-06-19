#!/usr/bin/env bash

# TODO more info but not on every prompt
# PS1+="${MAGENTA}[${RESET}"
# PS1+="${CYAN}\u${RESET}"
# PS1+="${LRED}@${RESET}"
# PS1+="${LCYAN}\h${RESET}"
# PS1+="${MAGENTA}]${RESET}"
# PS1+="${LBLUE}:${RESET}"
# PS1+="${LGREEN}:${RESET}"

__prompt_command() {
    # {{{
    # Because sometimes z.lua fucks up
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
    PS1+="${LMAGENTA}$PSC ${RESET}"
} # }}}
