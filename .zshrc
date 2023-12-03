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
bindkey \^U backward-kill-line
alias ls="ls --color"

conditional_source () {
	[ -f "$1" ] && source "$1"
}

#aliases
conditional_source "/etc/.aliasrc"
conditional_source "$HOME/.aliasrc"

#functions
conditional_source "/etc/.funcrc"
conditional_source "$HOME/.funcrc"

#common variables
conditional_source "/etc/.varrc"
conditional_source "$HOME/.varrc"

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

my-backward-delete-word () {
   local WORDCHARS='~!#$%^*<>?+'
   zle backward-delete-word
}

zle -N my-backward-delete-word
bindkey    '\e^?' my-backward-delete-word

eval "$(direnv hook zsh)"
if [ -e /home/michal/.nix-profile/etc/profile.d/nix.sh ]; then . /home/michal/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
