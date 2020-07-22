# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# returns whether the given command is executable or aliased
_has() {
    return $( whence "$1" > /dev/null 2>&1 )
}

##############
# Set up zsh #
##############

export ZSH="/home/anson/.oh-my-zsh"


ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh


################################
# Basic terminal configuration #
################################

# Load the shell dotfiles, and then some:
# ~/.path can be used to extend `$PATH`
# ~/.extra can be used for other settings you don't want to commit
for file in ~/.{path,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;


################################
# Manage programming languages #
################################

# start pyenv if it's installed
if _has pyenv; then
    eval "$(pyenv init -)"
fi

# set up virtualenvwrapper for managing local python environments
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source $HOME/.local/bin/virtualenvwrapper.sh

# set up nvm for managing node versions
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# User configuration

# fzf + ripgrep
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    '
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# make folders for vim
for folder in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
    [ ! -d "$folder" ] && mkdir -p $folder
done

# use vim keybindings in shell
bindkey -v

# remove duplicates from PATH
typeset -U path

# clean up history searching
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# turn on zsh syntax highlighting - should be near the end
source /home/anson/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# set up Tilix terminal
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
