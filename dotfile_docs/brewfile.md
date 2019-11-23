# Homebrew

Homebrew is a package manager for macOS. It works similarly to `apt-get` for Ubuntu, or `chocolatey` 
for PowerShell, and makes it easier to automate installing a given set of apps on a new machine.

1. [Install Homebrew](https://brew.sh) using the ruby command on the official site
2. If you already have a `brewfile` (or are using mine), all that's left is to run `brew bundle` from
   your home directory to install everything.
3. If you don't have a brewfile, eventually you may find you have a lot of stuff installed with brew
   that you want to remember for later. Since you probably don't remember them all, you can use
   `brew bundle dump`, which will generate a Brewfile for you in the current directory using everything
   you have currently installed through Brew. From there, you may want to edit by hand to remove
   the stuff you inevitably don't need any longer. If you already have a Brewfile and want to write
   the results to a different location, you can use `brew bundle dump --file=NewBrewFile` instead
4. If you add more apps to your Brewfile later on, you can easily run it again with `brew bundle`
   and it will only install whatever is missing.
5. For more information about how to create a Brewfile by hand, check out the
   [official README](https://github.com/Homebrew/homebrew-bundle)
6. If you want to use your Brewfile to install apps from the Mac App Store, you should check out
   the [mas-cli](https://github.com/mas-cli/mas) as well.
