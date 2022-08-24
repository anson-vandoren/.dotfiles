sudo pacman -S neovim exa dog curlie fd bat alacritty qutebrowser jq unzip fzf pv hunspell ranger
yay -S gotop tre-command 1password wlogout

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installing Powerlevel 10K"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "TODO:"
echo "- Install 1Password CLI: https://developer.1password.com/docs/cli/get-started#install"

