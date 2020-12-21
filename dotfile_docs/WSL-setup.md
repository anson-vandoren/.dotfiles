# WSL

Install WSL per [these instructions](https://docs.microsoft.com/en-us/windows/wsl/install-win10). It is possible to have both WSL1 and WSL2 distros
running on the same computer, and may be needed since WSL2 still doesn't support USB or serial communications :/

# Update distro

```bash
$ sudo apt update && sudo apt upgrade
```

# Add new distro to Windows Terminal (if desired)

```json
// settings.json
{
    "profiles":
    {
        "list":
        [
            {
                "guid": "{see below}",
                "hidden": false,
                "name": "Ubuntu-20.04",
                "source": "Windows.Terminal.Wsl",
                "fontFace": "MesloLGS NF",
                "fontSize": 12,
                "colorScheme": "FrontEndDelight",
                "startingDirectory": "//wsl$/Ubuntu-20.04/home/yourname"
            }
        ]
    }
}
```

To find the `guid`, see [this article](https://blog.itpro.tv/windows-terminal-guids-for-the-profiles-json-file/).

Spoiler: 
- Open regedit and go to `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\PackageFamily\Data\`
- Search from here for "Ubuntu" and look for the right distro name under the key `PackageFamilyName`.
- The GUID is under the key `Publisher`, everything after `CN=`

If the FrontEndDelight color scheme is not already present it can be added as below (in the same settings.json file).
Font also may need to be added or changed.

```json
    "schemes": [
        {
            "name": "FrontEndDelight",
            "black": "#242526",
            "red": "#f8511b",
            "green": "#565747",
            "yellow": "#fa771d",
            "blue": "#2c70b7",
            "purple": "#f02e4f",
            "cyan": "#3ca1a6",
            "white": "#adadad",
            "brightBlack": "#5fac6d",
            "brightRed": "#f74319",
            "brightGreen": "#74ec4c",
            "brightYellow": "#fdc325",
            "brightBlue": "#3393ca",
            "brightPurple": "#e75e4f",
            "brightCyan": "#4fbce6",
            "brightWhite": "#8c735b",
            "background": "#1b1c1d",
            "foreground": "#adadad"
          }
    ],
```

# Prepare for dotfiles

## Add to `.bashrc` (assuming it's still the default shell)

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Modify path to `git` if needed after checking with `which git`. If Git is not already installed (it should be), install it
with `sudo apt install git` first.

## Clone the dotfiles repo on the WSL branch

```bash
$ git clone -b WSL --separate-git-dir=$HOME/.dotfiles https://github.com/anson-vandoren/.dotfiles.git tmpdotfiles
$ rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
$ rm -r tmpdotfiles
```

## Stop showing untracked files

```sh
$ config config --local status.showUntrackedFiles no
```

# Install nvm & Node

The `.gitconfig` uses `diff-so-fancy`, so using git for remainder of setup will be a lot easier if that script is installed.
This can be installed directly from [its GitHub repo](https://github.com/so-fancy/diff-so-fancy), but then you have to
manage the script location manually. Easier to install it from NPM instead.

## Install nvm

```sh
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
```

The dotfiles `.zshrc` already has the correct `NVM_DIR` export so don't worry about that for now.

## Install Node

```sh
$ nvm install stable
```

### Install `diff-so-fancy`

```sh
$ npm install -g diff-so-fancy
```

# Install python3 and pip

```sh
$ sudo apt install python3 python3-pip
```

> Note: `.aliases` already maps `python` and `pip` to `python3` and `pip3`. Python2 is dead... If you
are using `pyenv` to manage versions you may want to remove this alias and install python
with `pyenv` instead of directly as shown above.

# Install `zsh` and `oh-my-zsh`

```sh
$ sudo apt update && sudo apt install zsh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Installing oh-my-zsh will overwrite the `.zshrc` file from the already-present dotfiles, so restore it

```sh
$ mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
```

# Install Powerlevel10k

Should be straightforward, from [here](https://github.com/romkatv/powerlevel10k). Don't forget to install MesloGS font first, then

```sh
$ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

The dotfiles .zshrc already has the theme set correctly. Restart the shell to get Powerlevel10k configuration and
setup as desired.

# Finish setting up Git

Download `.extra` file from secret Gist.

Create GPG key (if needed) and upload to GitHub per [their instructions](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-gpg-key)

Once you have a key, the `.extras` file will prompt you on next reload (or sourcing of it) to choose 
which key to use. Once you have a key, get the public key with 

```sh
$ gpg --list-secret-keys --keyid-format LONG
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot 
ssb   4096R/42B317FD4BA89E7A 2016-03-10
$ gpg --armor --export 42B317FD4BA89E7A
```

and upload it on GitHub

# Install other things from `.zshrc`

## Install `zsh-syntax-highlighting`

Optional instructions [here](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md).

TLDR:

```sh
$ sudo apt install zsh-syntax-highlighting
```

## Install `virtualenvwrapper`

```sh
$ pip install virtualenvwrapper
```

For possible error messages, [this may be helpful](https://gist.github.com/dixneuf19/a398c08f00aac24609c3cc44c29af1f0).

# Other utilities, etc.

## Bat (`cat` replacement with better formatting)

```sh
$ sudo apt install bat
$ mkdir -p ~/.local/bin
$ ln -s /usr/bin/batcat ~/.local/bin/bat
```

> Note: second and third steps may not be necessary if `apt` actually kept the name `bat` instead of `batcat`. YMMV.

> Note: this had conflicts with `ripgrep` when I tried last. Instead, download latest 
release from [GitHub](https://github.com/sharkdp/bat/releases) and install with `dpkg -i bat_0.16.0_amd64.deb` (for example)

## Exa (`ls` replacement with more color)

### Ubuntu 20.10 or later:

```sh
$ sudo apt install exa
```

### Earlier Ubuntu versions

Instructions [here](https://the.exa.website/install/linux#manual)

- Download [exa's Linux binary](https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip)
to somewhere correct (?) like `$HOME/.local/bin/`, and make sure that path is in `PATH`.
- Download [exa's man page](https://raw.githubusercontent.com/ogham/exa/master/contrib/man/exa.1) and put it
into `/usr/share/man/man1/` (NOTE: the link seems broken)
- Download [zsh completions](https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh)
and put it in `/usr/local/share/zsh/site-functions`

## Install `ripgrep`

```sh
$ sudo apt install ripgrep
```

## Install `fd`

```sh
$ sudo apt install fd-find
```

## Install `ag` (The Silver Searcher)

```sh
$ sudo apt install silversearcher-ag
```

## Install `fzf`

```sh
$ sudo apt install fzf
```

# Setup VIM

## Install NEOvim

```sh
$ sudo apt install neovim
```

## Install `vim-plug`

```sh
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

or, if using NeoVim instead:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Start VIM and type `:PlugInstall`
