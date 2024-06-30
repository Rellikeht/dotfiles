#!/usr/bin/env zsh

# {{{ settings
HISTFILE=~/.histfile
WORDCHARS='%~!?+'

DISABLE_AUTO_UPDATE='true'
ZSH_AUTOSUGGEST_USE_ASYNC='true'
export POWERLEVEL9K_INSTANT_PROMPT=quiet
SAVEHIST=$HISTFILESIZE

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FCNTL_LOCK

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt AUTO_CD
setopt COMPLETE_ALIASES
# }}}

# {{{ bindings
bindkey -e
bindkey \^U backward-kill-line

# Ok, zsh is fucked, but multiline commands are also
bindkey -M emacs "^[[A" history-beginning-search-backward
bindkey -M emacs "^[[B" history-beginning-search-forward
bindkey -M emacs "^P" history-beginning-search-backward
bindkey -M emacs "^N" history-beginning-search-forward
# }}}

# {{{ completion
# This probably does nothing
zstyle :compinstall filename '~/.zshrc'
# zstyle :compinstall filename '/etc/zshrc'
# zstyle ':completion:*' rehash true

if [ -z "$__COMPINIT_RUN" ]; then
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zscompcache"

    autoload -Uz compinit
    compinit
    __COMPINIT_RUN=1
fi
# }}}

# {{{ sourcing
if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

conditional_source ~/.aliasrc.zsh
conditional_source ~/.funcrc.zsh
conditional_source "$HOME/.local/.zshrc"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
conditional_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Shit, removing this breaks zsh on arch :(((
conditional_source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
conditional_source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
conditional_source ~/.p10k.zsh
# }}}

# {{{ hooks
if fzf --zsh &>/dev/null; then
    eval "$(fzf --zsh)"
fi

if direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

if whichp z.lua &>/dev/null; then
    eval "$(z.lua --init zsh enhanced once)"
elif whichp z &>/dev/null; then
    . "$(whichp z)"
fi
# }}}

# {{{ other

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    unset ${$(typeset -m "DIRENV_*")%%=*}
fi

opam() {
    if [ -z "$OPAM_SWITCH_PREFIX" ] &&
        whichp opam &>/dev/null &&
        [ -f "$HOME/.opam" ]; then
        eval "$(/usr/bin/env opam env --shell bash)"
    fi
    /usr/bin/env opam $@
}

# }}}

# {{{ shit
if [ -z "$__CONDA_SETUP" ]; then
    __conda_setup="$(\"$HOME/.conda/bin/conda\" 'shell.zsh' 'hook' 2>/dev/null)"
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
# }}}
