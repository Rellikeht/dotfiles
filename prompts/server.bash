#!/usr/bin/env bash

__prompt_command() {
    # {{{

    # Because sometimes z.lua fucks up
    local EXT="$?"
    if [ -n "$EXIT" ]; then
        EXT="$EXIT"
    fi
    PS1=""

    if [ -n "$FULL_PS1" ]; then
        # PS1+="${MAGENTA}[${RESET}"
        PS1+="${CYAN}\u${RESET}"
        PS1+="${LRED}@${RESET}"
        PS1+="${LCYAN}\h${RESET} "
        # PS1+="${MAGENTA}]${RESET}"
        PS1+="${LBLUE}${RESET}"
    fi
    PS1+="${LMAGENTA}\w${RESET} "

    if [ "$EXT" != 0 ]; then
        PS1+="${LRED}"
    else
        PS1+="${LGREEN}"
    fi

    PS1+="[$EXT]${RESET}"
    if [ -n "$FULL_PS1" ]; then
        PS1+="\n"
    fi
    PS1+="${LCYAN}$PSC ${RESET}"

} # }}}
