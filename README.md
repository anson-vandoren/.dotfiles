# Setting up dotfiles management

Thanks to a [HN post](https://news.ycombinator.com/item?id=11070797) and a post facto [blog post](https://www.anand-iyer.com/blog/2018/a-simpler-way-to-manage-your-dotfiles.html) for publicizing this method.

## Setting it up

### Make a bare git repo

```bash
$ mkdir $HOME/.dotfiles
$ git init --bare $HOME/.dotfiles
```

### Make a convenient alias for git to this repo

Add the line below to `.bashrc` or `.zshrc`

`alias dotfiles='usr/local/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'`

### Don't show all untracked files (since it will show ALL files no matter your path)

`dotfiles config --local status.showUntrackedFiles no`

### Create a new repository on GitHub (or wherever), and add the remote

`dotfiles remote add origin git@github.com:anson-vandoren/.dotfiles.git`

### Add files and push

```bash
$ cd $HOME
$ dotfiles add .vimrc
$ dotfiles commit -m "Adding .vimrc"
$ dotfiles push
```

## Setting up a new machine

### Try to just clone the repo as-is (note, this may fail)

`git clone --separate-git-dir=$HOME/.dotfiles https://github.com/anson-vandoren/.dotfiles.git ~`

### If this fails:

The `git clone` may fail if your new machine already has some configuration files in the $HOME directory
that match the files you have in your repo. If this happens, just clone into a new temporary directory,
copy the config to $HOME from there, and then delete temporary directory when finished

```bash
$ git clone --separate-git-dir=$HOME/.dotfiles https://github.com/anson-vandoren/.dotfiles.git tmpdotfiles
$ rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
$ rm -r tmpdotfiles
```
