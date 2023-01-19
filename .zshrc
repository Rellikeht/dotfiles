# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
alias ls="ls --color"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/michal/.zshrc'

zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#aliases
[ -f "/etc/.aliasrc" ] && source "/etc/.aliasrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

#functions
[ -f "/etc/.funcrc" ] && source "/etc/.funcrc"
[ -f "$HOME/.funcrc" ] && source "$HOME/.funcrc"

#common variables
[ -f "/etc/.varrc" ] && source "/etc/.varrc"
[ -f "$HOME/.varrc" ] && source "$HOME/.varrc"

my-backward-delete-word () {
   local WORDCHARS='~!#$%^*<>?+'
   zle backward-delete-word
}
zle -N my-backward-delete-word

bindkey    '\e^?' my-backward-delete-word

#source /home/michal/.config/broot/launcher/bash/br
