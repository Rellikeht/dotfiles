# vim: set syn=bash ft=bash:
#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

if ! conditional_source ~/.prompt.bash >/dev/null 2>/dev/null; then
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

if [ -n "$FZF_STARTUP_LOCATION" ]; then
    conditional_source "$FZF_STARTUP_LOCATION/share/fzf/completion.bash"
    conditional_source "$FZF_STARTUP_LOCATION/share/fzf/key-bindings.bash"
fi

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    # unset env vars starting with DIRENV_
    unset "${!DIRENV_@}"
fi

eval "$(direnv hook bash)"

if whichp opam >/dev/null 2>/dev/null; then
    eval "$(opam env --shell bash)"
fi

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
