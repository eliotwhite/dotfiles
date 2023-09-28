# Eliot's Dotfiles

## What Is This?

This repository contains configuration files and an install script to set up MacOS and Linux computers (or virtual machines) exactly the way I like them. At the end of the installation, depending on the machine's platform and architecture, I have a computer running zsh + oh my zsh + powerlevel10k with homebrew, my standard apps/brews, and the dotfiles set up just the way I like them. Additional configuration is needed for powerlevel10k after installation is complete.

## A Fresh MacOS Setup

Follow these install instructions to setup a new Mac.

1. Update MacOS to the latest version
2. Install MacOS Command Line Tools: `xcode-select --install`
3. Download and import the [Nord Terminal profile](https://github.com/nordtheme/terminal-app) and make it the default
4. Run `mkdir ~/.dotfiles`
5. Run `git clone https://github.com/eliotwhite/dotfiles.git ~/.dotfiles`
6. Run `./~/.dotfiles/install.sh` to start the installation
7. Install the [recommended powerlevel10k fonts](https://github.com/romkatv/powerlevel10k/blob/master/font.md)
8. Restart Terminal
9. Change Terminal profile (Nord) to use p10k fonts
10. Go through the powerlevel10k configuration wizard (run `p10k configure` if it doesn't start on its own)
11. Restore preferences by running `mackup restore`
12. Restart the computer to finalize the process

The Mac is now ready to use!

## A Fresh Linux Setup

Given I'm a Mac user, the only instances in which I'm setting up fresh Linux installations is with virtual machines or machines I'm ssh'ing to from a Mac. Thus, this process is a little less involved than setting up a Mac.

1. Update packages: `sudo apt-get update && sudo apt-get upgrade`
2. Run `mkdir ~/.dotfiles`
3. Run `git clone https://github.com/eliotwhite/dotfiles.git ~/.dotfiles`
4. Run `~/.dotfiles/install.sh` to start the installation
5. Restart the terminal session, most likely with `exit`
6. Go through the powerlevel10k configuration wizard (run `p10k configure` if it doesn't start on its own)

The Linux setup is complete!

## Your Own Dotfiles

I built this repo based on the work of others, and adapted it as needed. You can do the same! Just clone this repo and tweak away.

The [`Brewfile`](./Brewfile) applies to Mac installations only, and the selection of desired applications is particular to each person. They have a [search function](https://brew.sh/) on their home page you can use to see whether your desired tools and applications are available.

[Aliases](./omz-custom/aliases.zsh), your [`$PATH`](./omz-custom/paths.zsh), [functions](./omz-custom/functions.zsh), and [environment variables](./omz-custom/env.zsh) are all configurable based on your needs.

## License

The MIT License. Please see [the license file](license.md) for more information.