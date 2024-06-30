#!/usr/bin/env bash
#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

HISTFILE=~/.bash_history
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
shopt -s autocd

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

bind '"[A" history-search-backward'
bind '"[B" history-search-forward'
bind '"" history-search-backward'
bind '"" history-search-forward'

if ! conditional_source ~/.prompt.bash &>/dev/null; then
    PSC='$'
    [ "$(id -u)" -eq 0 ] && PSC='#'
    PS1='\[\033[34m\][\[\033[1;34m\]\u\[\033[1;36m\]@\[\033[1;31m\]\h\[\033[0;34m\]]\[\033[1;36m\]:\[\033[1;35m\]\w\[\033[1;33m\]$PSC\[\033[0m\] '

    PS2=">"
    PS3=""
    PS4="+"
fi

conditional_source ~/.aliasrc.bash
conditional_source ~/.funcrc.bash
conditional_source "$HOME/.local/.bashrc"

if fzf --bash &>/dev/null; then
    eval "$(fzf --bash)"
fi

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    # unset env vars starting with DIRENV_
    unset "${!DIRENV_@}"
fi

if direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

opam() {
    if [ -z "$OPAM_SWITCH_PREFIX" ] &&
        whichp opam &>/dev/null &&
        [ -f "$HOME/.opam" ]; then
        eval "$(/usr/bin/env opam env --shell bash)"
    fi
    /usr/bin/env opam $@
}

if [ -z "$__CONDA_SETUP" ]; then
    __conda_setup=$("$HOME/.conda/bin/conda" 'shell.bash' 'hook' 2>/dev/null)
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/.conda/etc/profile.d/conda.sh" ]; then
            . "$HOME/.conda/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/.conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    export __CONDA_SETUP=1
fi
