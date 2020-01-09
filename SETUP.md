# Elementary OS

## install xcape

`sudo apt install xcape`
add to zshrc (or .profile? or .xinitrc?):

- `setxkbmap -option ctrl:swapcaps`
- `xcape -e 'Control_L=Escape'`

## install basics

`sudo apt install git tmux xclip`

## setup ssh key and add to github

```bash
$ ssh-keygen -t rsa -b 4096 -C "anson.vandoren@gmail.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_rsa
$ xclip -sel clip < ~/.ssh/id_rsa.pub
```

Add SSH public key to GitHub

## copy .extra file from private gist

```bash
$ git clone git@gist.github.com:adb48de6130eeacf27ec8f545d839cf6.git extradir
$ cp extradir/.extra ~/.extra
$ rm -rf extradir
```

## create gpg key

[GitHub instructions](https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key)

```bash
$ gpg --full-generate-key
```

- Select (1) RSA and RSA (default)
- 4096 bits
- Key does not expire

### Get the KeyID:

`gpg --list-secret-keys --keyid-format LONG`

### export public key

`gpg --armor --export KEYID | xclip -sel clip`

### add GPG key to GitHub

[SSH and GPG keys on GitHub](https://github.com/settings/keys)

### source extras file

`source ~/.extra`

## Clone dotfiles

```bash
$ git clone --branch linux --separate-git-dir=$HOME/.dotfiles https://github.com/anson-vandoren/.dotfiles.git tmpdotfiles
$ rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
$ rm -r tmpdotfiles
```

Set config to not show untracked
`config config --local status.showUntrackedFiles no

## install zsh

`sudo apt install zsh`
`sudo chsh -s /usr/bin/zsh anson`

## install homebrew for linux

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"`
`sudo apt install build-essential`
`echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile`
`eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)`
`brew install gcc`

## add directories for vim

```bash
$ mkdir ~/.vim/swaps
$ mkdir ~/.vim/backups
$ mkdir ~/.vim/undo
```

## install vim-plug (if not already from dotfiles)

```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Start vim and run `:PlugInstall`
May need to install `prettier`, `black`, etc first via linuxbrew

## terminal color schemes in Elementary OS

install with [Gogh](https://mayccoll.github.io/Gogh/)
`bash -c "$(wget -qO- https://git.io/vQgMr)"`
select color scheme 48 (frontend-delight)

## pull in elementaryOS dconf settings

`cat .config/.elementary-dconf.ini | dconf load`
or
`dconf load / < .config/.elementary-dconf.ini`

to save them again:
`dconf dump / > .config/.elementary-dconf.ini`
may need to be edited to exclude non-needed

## install oh-my-zsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

copy dotfiles .zshrc over the oh-my-zsh new file:
`mv .zshrc.pre-oh-my-zsh .zshrc`

## install pyenv

`brew install pyenv`

install pyenv build deps
`sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \ libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \ xz-utils tk-dev libffi-dev liblzma-dev python-openssl git`

install zsh-syntax-highlighting and zsh-completions
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
`git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions`

## install virtualenvwrapper

Install pip (`sudo apt install python3-pip`) if needed
`pip3 install virtualenvwrapper`

### powerline fonts
[see instructions here](https://medium.com/@ilovepixelart/elementary-os-5-0-juno-oh-my-zsh-16a0cf0284b1)
