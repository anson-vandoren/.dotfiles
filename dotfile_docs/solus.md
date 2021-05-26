# Install utilities

```sh
$ sudo eopkg install git neovim
$ sudo eopkg install -c system.devel
```

# Create SSH key with YubiKey

```sh
$ ssh-keygen -t ecdsa-sk -C "your_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ecdsa-sk
$ xclip -sel clipboard < ~/.ssh/id_ecdsa-sk
```

# Get rid of global, sudo'ed Node and use NVM instead

```sh
$ sudo eopkg remove nodejs
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
$ nvm install stable
```

_don't forget to update .zshrc with the required NVM exports_

# Use `pyenv`

```sh
$ curl https://pyenv.run | bash
```

Add what it suggests to .zshrc (or .path, .profile, whatever)

### Install python build deps

```sh
$ sudo eopkg it -c system.devel
$ sudo eopkg install git gcc make zlib-devel bzip2-devel readline-devel sqlite3-devel openssl-devel tk-devel
```

### Install latest python3

```sh
# ...check latest version...
$ pyenv install 3.10.0b1
$ pyenv global 3.10.0b1
```

# Install `zsh` and `oh-my-zsh`

```sh
$ sudo eopkg install zsh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# Install fonts

- Install `font-manager` from Solus Software Center
- Download MesloLGS fonts from [Powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) page
- From page above, set up font in Alacritty or whatever terminal - lots of good instructions

# Install Powerlevel10k


# Install other useful things

```sh
$ sudo eopkg install hugo
$ npm install -g diff-so-fancy
```


# Install software from Software Center

- [Alacritty](https://github.com/alacritty/alacritty)
  - Alacritty config file included in `~/.config/alacritty/alacritty.yml`

# Install other software

- [JetBrains Toolbox](https://www.phillipsj.net/posts/jetbrains-toolbox-on-solus/)
  - Install whatever IDEs desired from the Toolbox
- [`logid`](https://xtonousou.xyz/0x1hardware-configure-use-logitech-mx-master-3-wireless-mouse-on-linux), build from source, for MX Master 3
  - Config file needs to be copied from `~/.config/logid.cfg` to `/etc/logid.cfg`
  - After building `logid`, start systemd service with `sudo systemctl enable --now logid`
- [Fix caps lock](https://ansonvandoren.com/posts/capslock-linux-redux/)

# Tweak Gnome

```sh
$ gsettings set org.gnome.desktop.interface cursor-size 32
$ gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15
$ gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```

# Enable Trezor wallet

```sh
$ sudo curl https://data.trezor.io/udev/51-trezor.rules -o /etc/udev/rules.d/51-trezor.rules
```
