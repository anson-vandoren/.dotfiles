# zmodload zsh/zprof
#############
# Zsh setup #
#############
export ZSH="$HOME/.oh-my-zsh"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=false
# ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  # asdf
  fzf-tab
  zsh-completions
  zsh-nvm
  zsh-syntax-highlighting
  # docker
  # docker-compose
  # zsh-better-npm-completion
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=${ZDOTDIR:-~}/.zsh_functions

HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

#####################
# Source other conf #
#####################
for file in ~/.{exports,aliases,functions,extra,paths}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

################################
# Manage programming languages #
################################

# setup nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###############
# Other tools #
###############

# fzf with ripgrep
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# make folders for vim
for folder in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
  [ ! -d "$folder" ] && mkdir -p $folder
done

# remove duplicates in PATH
typeset -U path

# vi mode
bindkey -v
# get rid of the lag going to normal mode
export KEYTIMEOUT=1

# clean up history searching
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# source fzf - seems to need to be near the bottom
# if [ -d /usr/share/fzf ]; then
  # completions below must be sourced to get **-<TAB> auto-completion
  . /usr/share/fzf/completion.zsh
  # key-bindings below must be sourced to get CTRL-R and CTRL-T and ALT-C behavior
  . /usr/share/fzf/key-bindings.zsh
# fi

# fzf-tab
zstyle ':fzf-tab:complete:git-checkout:*' fzf-command gbf # show results of git-branch for auto-completing git-checkout

eval $(thefuck --alias)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
alias cd='z'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/home/anson/.local/bin/mise activate zsh)"
eval "$(~/.local/bin/mise activate zsh)"
# zprof
. "$HOME/.cargo/env"
