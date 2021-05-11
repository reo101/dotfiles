# Setup fzf
# ---------
if [[ ! "$PATH" == */home/reo101/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/reo101/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/reo101/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/reo101/.fzf/shell/key-bindings.bash"
