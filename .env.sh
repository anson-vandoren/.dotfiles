#!/bin/zsh

export EDITOR=vim

# Create a folder and move into it in one command
function mkd() { mkdir -p "$@" && cd "$_"; }

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

# Aliases
source ~/.aliases

