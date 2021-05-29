# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

####################
# Helper functions #
####################
_has() {
    return $( whence "$1" > /dev/null 2>&1 )
}

#############
# Setup zsh #
#############
export ZSH="/home/anson/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    bgnotify
    git
    zsh-completions
    zsh-syntax-highlighting
    #zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Source external files
for file in ~/.{exports,aliases,functions,extra}; do
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
source ~/.local/bin/virtualenvwrapper.sh

# start nvm for managing node versions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###########################
# Other utilities & tools #
###########################

# fzf with ripgrep
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_EFAULT_OPTS='
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    '
fi

# fzf, must be done after zsh-vi-mode plugin is done loading, otherwise
# it gets clobbered
#zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# make folders for vim
for folder in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
    [ ! -d "$folder" ] && mkdir -p $folder
done

# remove duplicates from PATH
typeset -U path

# vi mode
bindkey -v

# clean up history searching
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source fzf - seems to need to be near the bottom
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
