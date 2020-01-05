# Windows (WSL) setup

# install TLDR
```sh
$ sudo apt install tldr
```

```sh
$ sudo apt install fontconfig
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

### set .ssh/config permissions:
```sh
$ chmod 600 ~/.ssh/config
$ chown $USER ~/.ssh/config
```

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
$ sudo apt install zsh-syntax-highlighting
```
