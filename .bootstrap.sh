#!/usr/bin/env sh

# install Xcode tools needed for Homebrew
echo "Installing Xcode tools"
xcode-select --install

# install Homebrew
if test ! $(which brew); then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew"
brew update
brew upgrade --all

# install zsh
echo "Installing zsh"
brew install zsh
echo "Installing zsh line completions"
brew install zsh-completions
echo "Installing zsh syntax highlighting"
brew install zsh-syntax-highlighting
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
