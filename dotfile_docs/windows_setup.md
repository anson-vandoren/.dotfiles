# Windows (WSL) setup


# install TLDR
```sh
$ sudo apt install tldr
```

```sh
$ sudo apt install fontconfig
```

### install virtualenvwrapper **locally**
```sh
$ pip install --user virtualenvwrapper
```

### install powerline font
```sh
$ wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
$ wget
https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
$ mkdir -p ~/.local/share/fonts/
$ mkdir -p ~/.config/fontconfig/conf.d/
$ mv PowerlineSymbols.otf ~/.local/share/fonts/
$ fc-cache -vf ~/.local/share/fonts/
$ mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```

### install MesloLGS NF font

https://gist.github.com/romkatv/aa7a70fe656d8b655e3c324eb10f6a8b

### set Windows Terminal config

```json
{
    "colorScheme": "FrontEndDelight",
    "fontFace": "MesloLGS NF",
    "fontSize": 11
}
```

### install powerlevel9k
```sh
$ git clone https://github.com/bhilburn/powerlevel9k.git
~/.oh-my-zsh/custom/themes/powerlevel9k
```

### set .ssh/config permissions:
```sh
$ chmod 600 ~/.ssh/config
$ chown $USER ~/.ssh/config
```

### run :PlugInstall in vim

## generate new gpg key
```sh
$ gpg --full-generate-key
```

- RSA and RSA (default)
- 4096 bits
- No expiry

Reload shell and let .extras file fill in the details

## get ready for zsh
```sh
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

## install linuxbrew
```sh
$ sh -c "$(curl -fsSL
https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
```

## install fzf

## install ag

