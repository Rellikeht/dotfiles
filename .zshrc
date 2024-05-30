# vim: set syn=zsh ft=zsh:

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=2000
WORDCHARS='%~!?+'

DISABLE_AUTO_UPDATE='true'
ZSH_AUTOSUGGEST_USE_ASYNC='true'
POWERLEVEL9K_INSTANT_PROMPT=quiet

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FCNTL_LOCK

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
# setopt SHARE_HISTORY

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

source ~/.commonrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
conditional_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Shit, removing this breaks zsh on arch :(((
conditional_source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
conditional_source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
conditional_source ~/.p10k.zsh

conditional_source "$FZF_STARTUP_LOCATION/share/fzf/completion.zsh"
conditional_source "$FZF_STARTUP_LOCATION/share/fzf/key-bindings.zsh"

eval "$(direnv hook zsh)"

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
