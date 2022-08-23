#####################
## Helper functions #
#####################
#
_has() {
  return $(whence "$1" > /dev/null 2>&1 )
}


# The following lines were added by compinstall
zstyle :compinstall filename '/home/anson/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
#

source ~/.aliases
source ~/.functions
