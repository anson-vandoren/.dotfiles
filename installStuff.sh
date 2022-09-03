#!/bin/sh
# set terminal font size larger
echo "Setting the terminal font size larger, use sudo setfont ter-v16b to set it back"
sudo pacman -Sy
sudo pacman -S --needed terminus-font
fc-cache -fv 2>&1 1>/dev/null
sudo setfont ter-v32b

# install rustup & rust first
if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "rustc already installed, skipping rustup"
fi

# Install bare necessities
sudo pacman -S --needed sway alacritty waybar xorg-xwayland xorg-xlsclients swayidle swaylock swaybg
sudo pacman -S --needed man python-pip  pamixer wget atop mpd alsa-utils pavucontrol \
	python-gobject openssh tmux pipewire-pulse
sudo pacman -S --needed libfido2 unzip zip tar unrar htop clang cmake npm linux-headers zsh-completions pkgconfig \
	autoconf automake p7zip bzip2 zstd xz gzip lsof
sudo pacman -S --needed libvirt amd-ucode qemu-base lxsession-gtk3 seahorse bluez bluez-utils blueman
# fonts
sudo pacman -S --needed ttf-dejavu ttf-liberation noto-fonts ttf-jetbrains-mono noto-fonts-cjk noto-fonts-extra \
	noto-fonts-emoji ttf-roboto ttf-inconsolata ttf-font-awesome ttf-ubuntu-font-family
sudo pacman -S --needed slurp grim swappy wl-clipboard ripgrep pdfjs
# programming languages
sudo pacman -S --needed jre-openjdk jdk-openjdk go docker docker-compose nodejs npm python-virtualenv \
	python-virtualenvwrapper thefuck ctags github-cli
pip install virtualenvwrapper neovim
source /usr/bin/virtualenvwrapper.sh
# network
sudo pacman -S --needed dhcpcd
# graphics
sudo pacman -S --needed mesa libva-mesa-driver mesa-vdpau vulkan-radeon xf86-video-amdgpu glfw-wayland \
    qt5-wayland glew-wayland libva-vdpau-driver libvdpau-va-gl libva-utils vdpauinfo
# applications
sudo pacman -S --needed neovim exa dog curlie fd bat alacritty jq unzip fzf pv hunspell ranger thunar tldr \
	telegram-desktop wf-recorder vlc guvcview
# Install yay if not present
if ! command -v yay &> /dev/null; then
  echo "Intstalling yay"
  mkdir -p ~/src
  git clone https://aur.archlinux.org/yay.git ~/src/yay
  cd ~/src/yay && makepkg -si
  rm -rf ~/src/yay
else
  echo "yay already installed, skipping"
fi
# Install others
yay -S --needed --answerclean No --answerdiff N gotop tre-command 1password wlogout qutebrowser-qt6-git \
	slack-desktop toggldesktop nvm swaynagmode jetbrains-toolbox zoom wshowkeys-git xawtv

# Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed, skipping"
fi
if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions ]; then
  echo "installing zsh-completions"
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi
if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting ]; then
  echo "installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-better-npm-completion ]; then
  echo "installing zsh-better-npm-completions"
  git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
fi
if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/fzf-tab ]; then
  echo "installing fzf-tab"
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/fzf-tab
fi
# Powerlevel10k
if (( $(fc-list | grep -i meslolgs | uniq | wc -l ) < 4 )); then
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

# npm globals
npm install -g prettier eslint yarn neovim

# start services
sudo systemctl enable --now docker
sudo systemctl enable --now dhcpcd
sudo systemctl enable --now avahi-daemon

# GPG
echo "Checking for existing GPG key"
if gpg --list-secret-keys | grep -q "^sec"; then
  echo "GPG key already exists"
else
  echo "Generating GPG key. Don't forget to use at least 4096 bits RSA"
  gpg --full-generate-key
fi


echo "TODO:"
echo "- Install 1Password CLI: https://developer.1password.com/docs/cli/get-started#install"

