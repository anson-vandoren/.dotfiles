#!/usr/bin/env sh

# set hostname everywhere
sudo scutil --set HostName      anson   # Common usage
sudo scutil --set LocalHostName anson   # Bonjour
sudo scutil --set ComputerName  anson   # Finder, friendly name

# install Xcode tools needed for Homebrew
echo "Installing Xcode tools"
xcode-select --install
sudo xcodebuild -license accept

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

## set some macOS defaults

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"


