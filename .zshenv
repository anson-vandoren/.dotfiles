. "$HOME/.cargo/env"
export PATH=$PATH:~/.local/bin

# prepare for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
