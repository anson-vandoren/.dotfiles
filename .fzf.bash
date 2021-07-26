# Setup fzf
# ---------
if [[ ! "$PATH" == */home/anson/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/anson/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/anson/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/anson/.fzf/shell/key-bindings.bash"
