#!/bin/sh
_has() {
  return $(whence "$1" > /dev/null 2>&1 )
}

# Install bare necessities
sudo pacman -S --needed sway alacritty waybar xorg-xwayland xorg-xlsclients qt5-wayland swayidle swaylock
sudo pacman -S --needed man python-pip pulseaudio-alsa pamixer wget atop mpd alsa-utils pavucontrol networkmanager network-manager-applet dhcpcd python-gobject openssh tmux
sudo pacman -S --needed libfido2
sudo pacman -S --needed ttf-dejavu ttf-liberation noto-fonts ttf-jetbrains-mono
sudo pacman -S --needed slurp grim wl-clipboard 
# Install yay if not present
if [ ! _has yay ]; then
  echo "Intstalling yay"
  mkdir -p ~/src
  git clone https://aur.archlinux.org/yay.git ~/src/yay
  cd ~/src/yay && makepkg -si
  rm -rf ~/src/yay
else
  echo "yay already installed, skipping"
fi
# Install others
sudo pacman -S --needed neovim exa dog curlie fd bat alacritty jq unzip fzf pv hunspell ranger thunar tldr
yay -S --needed --answerclean No --answerdiff n gotop tre-command 1password wlogout qutebrowser-qt6-git slack-desktop

# Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed, skippind"
fi
# Powerlevel10k
if [ $(fc-list | grep -i meslolgs | uniq | wc -l) lt 4 ]; then
  echo "Installing MesloLGS NF fonts"
  mkdir -p "$HOME/.local/share/fonts/ttf/MesloLGS"
  wget -nc -P "$HOME/.local/share/fonts/ttf/MesloLGS" \
	  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \
	  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf \
	  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf \
	  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
  fc-cache
else
  echo "MesloLGS NF fonts already installed"
fi
if [ ! -e "$HOME/.p10k.zsh" ]; then
  echo "Installing Powerlevel 10K"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "Powerlevel 10K already installed, skipping"
fi

echo "TODO:"
echo "- Install 1Password CLI: https://developer.1password.com/docs/cli/get-started#install"

