echo "adding backports"
echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee /etc/apt/sources/list.d/stretch-packports.list
sudo apt update

echo "installing tilix"
sudo apt -y install tilix
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh


echo "Updating Linux container"
sudo apt update && sudo apt upgrade && sudo apt dist-upgrade

echo "Installing zsh and oh my zsh"
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing python2/3 & their pips"
sudo apt install python python3 python-pip python3-pip

echo "installing curl & rsync"
sudo apt install curl rsync

# install fonts & powerlevel10k

echo "installing MesloLGS fonts"
mkdir -p $HOME/.fonts
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -LO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv ./MesloLGS*.ttf $HOME/.fonts/
fc-cache -fv


echo "Installinv nvim"
sudo apt install neovim

echo "Installing nvm and node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

nvm install node

echo "Installing diff-so-fancy"
npm install -g diff-so-fancy

echo "installing exa"
sudo apt install exa

echo "installing fd"
sudo apt install fd

echo "installing ag"
sudo apt install silversearcher-ag

echo "installing ripgrep"
sudo apt install ripgrep

