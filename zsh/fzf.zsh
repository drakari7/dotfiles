# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/shreyash/git/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/shreyash/git/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/shreyash/git/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/shreyash/git/fzf/shell/key-bindings.zsh"
