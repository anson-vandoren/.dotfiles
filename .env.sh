#!/bin/sh

# set preferred editor
export EDITOR='vim'

# let tmux know 256 colors are available
export TERM="xterm-256color"

# Fix GPG for git commit signing
export GPG_TTY=$(tty)

# make folders for vim
for folder in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
    [ ! -d "$folder" ] && mkdir -p $folder
done

# use vim keybindings in shell
bindkey -v

