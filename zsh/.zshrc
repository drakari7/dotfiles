# Config file for zsh

# Plugins managed with miniplug
export MINIPLUG_HOME="${ZDOTDIR}/plugins"
source "${ZDOTDIR}/miniplug.zsh"
miniplug plugin 'ael-code/zsh-colored-man-pages'
miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'zsh-users/zsh-completions'
miniplug plugin 'softmoth/zsh-vim-mode'
miniplug load

# Use starship for prompt
eval "$(starship init zsh)"

# Enable colors
autoload -U colors && colors

# ZSH options
unsetopt beep
setopt extendedglob
setopt nomatch

# History
HISTFILE="${ZDOTDIR}/history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt inc_append_history

# Tab completion
autoload -Uz compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Also show hidden files

# Zoxide configuration
if whence -p zoxide >/dev/null; then
  eval "$(zoxide init --cmd j zsh)"
fi

# Make up and down keys like bash
# Default values are history-beginning-search-backward-end and history-beginning-search-forward-end
bindkey "^[[A" up-history
bindkey "^[[B" down-history

# Disable sgr escape sequences (makes man pages colorful)
export GROFF_NO_SGR=1

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use hjkl in autocompcomplete menus
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Sourcing aliases and custom scripts
[ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"
[ -f ~/scripts/my_funcs.sh ] && source ~/scripts/my_funcs.sh
[ -f ~/scripts/fzf_aliases ] && source ~/scripts/fzf_aliases

# Set wordchars to modify ctrl-w behavior
export WORDCHARS='._-'

#### Fzf initialisation and settings
if whence -p fzf >/dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
  export FZF_DEFAULT_OPTS='--height=70% --layout=reverse'
fi

# zsh-vim-mode configs
MODE_CURSOR_VIINS="#ffffff blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="white block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

# Miscellaneous (Maybe move to .zshenv)
export PATH=~/scripts/:$PATH
export EDITOR="nvim"
export VISUAL="nvim"
