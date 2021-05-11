# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.config/zsh/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.config/zsh/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/zsh/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/zsh/fzf/shell/key-bindings.bash"
