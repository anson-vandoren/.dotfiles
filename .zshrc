# Uncommend below and zprof at the bottom to see why it's slow
# zmodload zsh/zprof 


##? Clone a plugin, identify its init file, source it, and add it to your fpath.
function plugin-load {
  local repo plugdir initfile initfiles=()
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
      ln -sf $initfiles[1] $initfile
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

repos=(
    Aloxaf/fzf-tab
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting

)
plugin-load $repos

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# oh-my-zsh

for file in ~/.{exports,aliases,functions,extra,paths}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;


###############
# Other tools #
###############

# fzf with ripgrep
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108,info:108,prompt:109,spinner:108,pointer:168,marker:168'

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
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt SHARE_HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# only check compinit once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(/home/anson/.local/bin/mise activate zsh)"

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
. ~/.fzf/shell/completion.zsh
. ~/.fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Uncomment this and the loading at the top to see why it's taking so long
# zprof
