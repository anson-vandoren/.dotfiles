# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

#####################
## Helper functions #
#####################
#
_has() {
  return $(whence "$1" > /dev/null 2>&1 )
}

#############
# Zsh setup #
#############
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  fzf-tab
  zsh-completions
  zsh-syntax-highlighting
  docker
  docker-compose
  zsh-better-npm-completion
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
source /usr/share/nvm/init-nvm.sh

# setup pyenv
if _has pyenv; then
  eval "$(pyenv init -)"
fi

# setup virtualenvwrapper
if [ -f /usr/bin/virtualenvwrapper.sh ]; then
  source /usr/bin/virtualenvwrapper_lazy.sh
else
  echo "missing /usr/bin/virtualenvwrapper_lazy.sh"
fi

###############
# Other tools #
###############

# fzf with ripgrep
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108,info:108,prompt:109,spinner:108,pointer:168,marker:168'
fi

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source fzf - seems to need to be near the bottom
if [ -d /usr/share/fzf ]; then
  # completions below must be sourced to get **-<TAB> auto-completion
  . /usr/share/fzf/completion.zsh
  # key-bindings below must be sourced to get CTRL-R and CTRL-T and ALT-C behavior
  . /usr/share/fzf/key-bindings.zsh
fi

# Auto-switch NPM versions when possible
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install &>/dev/null
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use &>/dev/null
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc &>/dev/null

# fzf-tab
zstyle ':fzf-tab:complete:git-checkout:*' fzf-command gbf # show results of git-branch for auto-completing git-checkout

eval $(thefuck --alias)
eval "$(starship init zsh)"
