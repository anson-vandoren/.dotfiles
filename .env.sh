#!/bin/zsh

export EDITOR=vim

# Create a folder and move into it in one command
function mkd() { mkdir -p "$@" && cd "$_"; }

# Aliases
source ~/.aliases

