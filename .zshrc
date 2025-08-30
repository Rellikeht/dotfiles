#!/usr/bin/env zsh

# settings {{{

HISTFILE=~/.histfile

# For deleting words to work acceptably
WORDCHARS='%~!?+'

# Perf improvement I guess
DISABLE_AUTO_UPDATE='true'
ZSH_AUTOSUGGEST_USE_ASYNC='true'

# For p10k to complain less
export POWERLEVEL9K_INSTANT_PROMPT=quiet

# History options
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FCNTL_LOCK
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# For z.sh completion to work properly
# but this is too valuable elsewhere
# setopt COMPLETE_ALIASES

# hidden files in completion yay
setopt globdots

# for colors in completion
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32'

setopt AUTO_CD

set -o pipefail

source_if_exists() {
    [ -r "$1" ] && source "$1"
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source_if_exists "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# }}}

# completion {{{

ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    forward-char
    forward-word
    emacs-forward-word
)

zmodload -i zsh/complist

# why does this make things faster
zstyle :compinstall filename '~/.zshrc'

# Some completion settings and activation {{{
if [ -z "$__COMPINIT_RUN" ]; then
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zscompcache"

    if [ -d "$HOME/.nix-profile/share/zsh/site-functions" ]; then
        fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
        local NIXFILE="$HOME/.nix-profile/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
        if ! type prompt_nix_shell_setup &>/dev/null && [ -f "$NIXFILE" ]; then
            source "$NIXFILE"
        fi
    fi

    # good stuff
    zstyle ':completion:*' menu select=long
    zstyle ':completion:*' verbose yes

    # ?
    zstyle ':completion:*' completer _expand _complete _ignored _approximate

    # colors files
    # zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

    # colors files until they have common prefix
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35;01}:${(s.:.)LS_COLORS}")';

        zstyle ':completion:*' matcher-list '' \
            'm:{a-z\-}={A-Z\_}' \
            'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
            'r:|?=** m:{a-z\-}={A-Z\_}'

    # {{{
    # smart case baby
    # zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
    # zstyle ':completion:*' matcher-list 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
    # }}}

    __COMPINIT_RUN=1
fi
# }}}

# some loading of completion
autoload -Uz compinit
compinit

# }}}

# bindings {{{

bindkey -e
bindkey \^U backward-kill-line

# Slightly better tab
bindkey -M emacs "^I" expand-or-complete-prefix
# and shift tab
bindkey -M emacs "^[[Z" reverse-menu-complete

# Ok, zsh is fucked, but multiline commands are also
bindkey -M emacs "^[[A" history-beginning-search-backward
bindkey -M emacs "^[[B" history-beginning-search-forward

# Just in case
bindkey -M emacs "^[OA" history-beginning-search-backward
bindkey -M emacs "^[OB" history-beginning-search-forward

# Because I don't use arrows anyway
bindkey -M emacs "^P" history-beginning-search-backward
bindkey -M emacs "^N" history-beginning-search-forward

# Selection in menu
bindkey -M menuselect "^P" up-line-or-history
bindkey -M menuselect "^N" down-line-or-history

bindkey -M emacs -s "^[i" "**	"

# }}}

# sourcing {{{

if [ -f "$HOME/.commonrc" ]; then
    source "$HOME/.commonrc"
fi

source_if_exists ~/.aliasrc.zsh
source_if_exists ~/.funcrc.zsh
source_if_exists "$HOME/.local/.zshrc"

# Shit, removing this breaks zsh on arch :(((
source_if_exists /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# p10k config
source_if_exists ~/.p10k.zsh

# }}}

# hooks {{{

if has_exe fzf; then
    FZF_COMPLETION_TRIGGER='**'
    eval "$(fzf --zsh)"
fi

# z.lua or plain old z as fallback
if has_exe lua && has_exe z.lua; then
    eval "$(z.lua --init zsh once enhanced echo)"
elif has_exe z; then
    . "$(whichp z)"
fi

if has_exe direnv; then
    eval "$(direnv hook zsh)"
fi

# }}}

# other {{{

# from .commonrc
SAVEHIST=$HISTFILESIZE

# Compatibility between tmux and direnv (?)
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    unset ${$(typeset -m "DIRENV_*")%%=*}
fi

# }}}

# shit {{{

if [ -z "$__CONDA_SETUP" ]; then
    if [ -d "$HOME/.conda" ]; then
        __conda_setup="$(\"$HOME/.conda/bin/conda\" 'shell.zsh' 'hook' 2>/dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$HOME/.conda/etc/profile.d/conda.sh" ]; then
                . "$HOME/.conda/etc/profile.d/conda.sh"
            else
                pathinsert "$HOME/.conda/bin:$PATH"
            fi
        fi
        unset __conda_setup
    fi
    export __CONDA_SETUP=1
fi

# }}}
