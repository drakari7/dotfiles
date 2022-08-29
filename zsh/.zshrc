# Config file for zsh

# Enable colors
autoload -U colors && colors

# History
HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch
unsetopt beep

# Tab completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Also show hidden files

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keybindings in autocompcomplete menus
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Sourcing aliases and other things
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"

# Plugins managed with miniplug
export MINIPLUG_HOME="${ZDOTDIR}/plugins"
source "${ZDOTDIR}/miniplug.zsh"

miniplug theme 'romkatv/powerlevel10k'
miniplug plugin 'ael-code/zsh-colored-man-pages'
miniplug plugin 'zpm-zsh/ls'
miniplug plugin 'agkozak/zsh-z'
miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'zsh-users/zsh-completions'
miniplug plugin 'softmoth/zsh-vim-mode'
miniplug load

# Source powerlevel10k
[ -f ~/.config/zsh/.p10k.zsh ] && source ~/.config/zsh/.p10k.zsh
[ -f "${ZDOTDIR}/fzf.zsh" ] && source "${ZDOTDIR}/fzf.zsh"
