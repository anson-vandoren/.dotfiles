# returns whether the given command is executable or aliased.
_has() {
    return $( whence "$1" > /dev/null 2>&1 )
}

#############
# Setup zsh #
############

# Path to your oh-my-zsh installation.
export ZSH="/Users/anson/.oh-my-zsh"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh

# set path for function definitions
export fpath=(/usr/local/share/zsh-completions $fpath)

# turn on zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


################################
# Basic terminal configuration #
################################

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

################################
# Manage programming languages #
################################

# start pyenv for managing python versions
if _has pyenv; then
    eval "$(pyenv init -)"
fi

# set up virtualenvwrapper for managing local python environments
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source /usr/local/bin/virtualenvwrapper.sh

# start nvm for managing node versions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Go setup
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# add path for homebrew sbins
export PATH="$PATH:/usr/local/sbin"

# fzf and ag setup
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
    export PATH="/Users/anson/.fzf/bin:$PATH"
    source ~/.fzf/shell/key-bindings.zsh
    source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    '
fi

# make folders for vim
for folder in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
    [ ! -d "$folder" ] && mkdir -p $folder
done

# use vim keybindings in shell
bindkey -v

# remove duplicates from PATH
typeset -U path


# set zsh theme and customize
POWERLEVEL9K_MODE='nerdfont-complete'
source ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time date)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""

# enable fuzzy finding with fzf via hotkeys
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable z - jump around
. /usr/local/etc/profile.d/z.sh

# clean up history searching
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
