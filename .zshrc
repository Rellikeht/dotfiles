# vim: set syn=zsh ft=zsh:

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=2000
WORDCHARS='%~!?+'

DISABLE_AUTO_UPDATE='true'
ZSH_AUTOSUGGEST_USE_ASYNC='true'

setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FCNTL_LOCK

# setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

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

#my-backward-delete-word () {
#   local WORDCHARS='~!#$%^*<>?+'
#   zle backward-delete-word
#}
#
#zle -N my-backward-delete-word
#bindkey    '\e^?' my-backward-delete-word

eval "$(direnv hook zsh)"
