#!/usr/bin/env zsh

export HISTFILE=~/.histfile
export WORDCHARS='%~!?+'

export DISABLE_AUTO_UPDATE='true'
export ZSH_AUTOSUGGEST_USE_ASYNC='true'
export POWERLEVEL9K_INSTANT_PROMPT=quiet
export SAVEHIST=$HISTFILESIZE

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FCNTL_LOCK

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

bindkey -e
bindkey \^U backward-kill-line

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

if fzf --zsh &>/dev/null; then
    eval "$(fzf --zsh)"
fi

# Compatibility between tmux and direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    unset ${$(typeset -m "DIRENV_*")%%=*}
fi

eval "$(direnv hook zsh)"

if opam &>/dev/null && [ -f "$HOME/.opam" ]; then
    eval "$(opam env --shell zsh)"
fi

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
