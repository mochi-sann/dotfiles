# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mochi/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mochi/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/mochi/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/mochi/.fzf/shell/key-bindings.zsh"
