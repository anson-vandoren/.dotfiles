# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# returns whether the given command is executable or aliased.
_has() {
    return $( whence "$1" > /dev/null 2>&1 )
}

#############
# Setup zsh #
############

# Path to your oh-my-zsh installation.
export ZSH="/Users/ansonvandoren/.oh-my-zsh"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

ZSH_THEME="powerlevel10k/powerlevel10k"
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
source $HOME/.local/bin/virtualenvwrapper.sh

# start nvm for managing node versions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Go setup
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# add path for homebrew sbins
export PATH="$PATH:/usr/local/sbin"

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

# fzf + ripgrep configuration
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
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

# make libffi and gcc work
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anson/Downloads/google-cloud-sdk/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/anson/Downloads/google-cloud-sdk/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anson/Downloads/google-cloud-sdk/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/anson/Downloads/google-cloud-sdk/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2021-03-12 23:52:14
export PATH="$PATH:/Users/ansonvandoren/.local/bin"
