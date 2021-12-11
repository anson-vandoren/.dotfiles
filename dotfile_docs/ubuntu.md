# Install dotfiles from repo

[Link here](https://github.com/anson-vandoren/.dotfiles/blob/solus/dotfile_docs/dotfile_management.md)

Note that some things may break, so you might want to do this later on instead...

# Install utilities

```sh
sudo apt install git neovim tmux
```

# Install delta for git diff/show

[From here](https://github.com/dandavison/delta)

# Create SSH key with YubiKey

```sh
ssh-keygen -t ecdsa-sk -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ecdsa-sk
xclip -sel clipboard < ~/.ssh/id_ecdsa-sk.pub
```

# Get rid of global, sudo'ed Node and use NVM instead

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install stable
```

> Check current version and update `curl` command as needed

_don't forget to update .zshrc with the required NVM exports_

# Use `pyenv`

```sh
curl https://pyenv.run | bash
```

Add what it suggests to .zshrc (or .path, .profile, whatever)

### Install python build deps

```sh
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

### Install latest python3

```sh
# ...check latest version...
pyenv install 3.10.0
pyenv global 3.10.0
```

### Install some python packages globally

```sh
pip install --upgrade pip
pip install --user black virtualenvwrapper
```

> NOTE: this installs both packages in ~/.local/bin/ which needs to be added to `$PATH`

# Install rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

# Install `zsh` and `oh-my-zsh`

```sh
sudo eopkg install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Log out and log back in again to actually get default shell to change

## Zsh plugins

```sh
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
```

Then add `plugins+=(zsh-vi-mode zsh-completions zsh-syntax-highlighting)` to `.zshrc`

# Install fonts

- Download MesloLGS fonts from [Powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) page
- From page above, set up font in Alacritty or whatever terminal - lots of good instructions

# Install Powerlevel10k

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Then make sure it's enabled in .zshrc, then `exec $SHELL` to get the setup wizard and run through it


# Create gpg key

```sh
gpg --full-generate-key
```

Make sure key size is >= 4096 bits, use GitHub email address.

Clone & source the private/secret .extra gist, verify GPG key is correct. This
will generate the `.gitconfig_private` file that is sourced in the `.gitconfig`
file from the dotfiles repo.

## Add gpg key to GitHub

```sh
gpg --list-secret-keys --keyid-format LONG
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot
ssb   4096R/42B317FD4BA89E7A 2016-03-10
$ gpg --armor --export 42B317FD4BA89E7A
```

...and upload it on GitHub.

# Install other useful things

```sh
sudo apt install hugo
npm install -g diff-so-fancy tldr
sudo apt install bat
ln -s /usr/bin/batcat ~/.local/bin/bat
sudo apt install fd-find ripgrep silversearcher-ag exa
sudo apt install httpie jq yarn
cargo install watchexec-cli
sudo apt install rofi
```

Install [curlie](https://github.com/rs/curlie/releases/tag/v1.6.0) from binary

Install [dog](https://github.com/ogham/dog) from binary, including completions
& man page.



## Install fzf from git to get completions and keybindings

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Then let the installer update shell config files

## Set up Ubuntu auth for Yubikey

See [this guide](https://pages.ubuntu.com/rs/066-EOV-335/images/Canonical_Authentication%20for%20Ubuntu%20Desktop_V6.pdf)
```sh
sudo apt install libpam-u2f
mkdir ~/.config/Yubico
pamu2fcfd > ~/.config/Yubico/u2f_keys
```

In `/etc/pam.d/common-auth` (after backing it up), add the line:

> Note: this should be above the line that asks for a password (`...pam_unix.so
nullok_secure`) and the `success=` value enough to skip that line.

```sh
auth [success=3 default=ignore] pam_u2f.so cue
```


## Install GoTop (graphical process monitor)

```sh
wget https://github.com/xxxserxxx/gotop/releases/download/v4.1.1/gotop_v4.1.1_linux_amd64.tgz
tar -xzf gotop_v4.1.1_linux_amd64.tgz
mv ./gotop ~/.local/bin
```

# Install software from Software Center

- [Alacritty](https://github.com/alacritty/alacritty)
  - Alacritty config file included in `~/.config/alacritty/alacritty.yml`

# Install other software

- [JetBrains Toolbox](https://www.phillipsj.net/posts/jetbrains-toolbox-on-solus/)
  - Install whatever IDEs desired from the Toolbox
- [`logid`](https://xtonousou.xyz/0x1hardware-configure-use-logitech-mx-master-3-wireless-mouse-on-linux), [build from source](https://github.com/PixlOne/logiops#dependencies), for MX Master 3
  - Config file needs to be copied from `~/.config/logid.cfg` to `/etc/logid.cfg`
  - After building `logid`, start systemd service with `sudo systemctl enable --now logid`
  - Will need to log out and back in again for this to take effect
- [Fix caps lock](https://ansonvandoren.com/posts/capslock-linux-redux/)

# Tweak Gnome

```sh
gsettings set org.gnome.desktop.interface cursor-size 32
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
```

Fix windows moving to different monitors after sleep

```sh
gsettings set org.gnome.settings-daemon.plugins.xrandr active false
```

# Enable Trezor wallet

```sh
sudo curl https://data.trezor.io/udev/51-trezor.rules -o /etc/udev/rules.d/51-trezor.rules
```

# Gnome shell extensions

```sh
sudo apt install gnome-shell-extensions gnome-tweaks
sudo apt install gnome-shell-extension-autohidetopbar
```

# Setup vim

# Install `vim-plug`

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Start vim and `:PlugInstall`

If `fzf` completions (specifically CTRL-R) break after this, try reinstalling
`fzf` from git again
