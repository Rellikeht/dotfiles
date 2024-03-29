# vim: set syn=zsh ft=zsh:

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS='%~!?+'

bindkey -e
bindkey \^U backward-kill-line

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit
# End of lines added by compinstall

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
