HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz compinit promptinit
compinit
promptinit

prompt redhat

zstyle ':completion:*' menu select

# Starship Initialization
eval "$(starship init zsh)"
