# Eliot's Dotfiles

## What Is This?

This repository…

## A Fresh MacOS Setup

Follow these install instructions to setup a new Mac.

1. Update MacOS to the latest version
2. Install MacOS Command Line Tools
3. Install 1Password and set up its SSH Agent functionality
4. Clone this repo to `~/.dotfiles`
5. Run `install.sh` to start the installation
6. Restore preferences by running `mackup restore`
7. Restart the computer to finalize the process

Your Mac is now ready to use!

## Your Own Dotfiles

If you want to start your own dotfiles from this setup, it's pretty easy to do so. First of all you'll need to clone this repo. After that you can tweak it the way you want.

Check out the [`Brewfile`](./Brewfile) and adjust the apps you want to install for your machine. Use [their search page](https://caskroom.github.io/search) to check if the app you want to install is available.

Check out the [`aliases.zsh`](./aliases.zsh) file and add your own aliases. If you need to tweak your `$PATH` check out the [`path.zsh`](./path.zsh) file.

One thing you'll need to do manually is add your `~/.zshrc` file. You can't symlink the `.zshrc` file from your dotfiles because Mackup will already symlink your `.zshrc` from your home directory. That's why we'll need to create the file manually. Add the contents below to a `.zshrc` file in your user directory. What it will do is load the `.zshrc` file from your dotfiles. Make sure that the path to your dotfiles is correct.

```zsh
# Load Zsh
source ~/.dotfiles/.zshrc
```

When installing these dotfiles for the first time you'll need to backup all of your settings with Mackup. Install and backup your settings with the command below. Your settings will be synced to your Dropbox so you can use them to sync between computers and reinstall them when reinstalling your Mac. If you want to save your settings to a different folder or different medium than Dropbox, [checkout the documentation](https://github.com/lra/mackup#supported-storages).

```zsh
brew install mackup
mackup backup
```
## License

The MIT License. Please see [the license file](license.md) for more information.