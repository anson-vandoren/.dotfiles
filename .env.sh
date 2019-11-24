#!/bin/sh

# set preferred editor
export EDITOR='vim'

# let tmux know 256 colors are available
export TERM="xterm-256color"

# Fix GPG for git commit signing
export GPG_TTY=$(tty)

# use vim keybindings in shell
bindkey -v

# Create a folder and move into it in one command
mkd() { mkdir -p "$@" && cd "$_"; }

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}
