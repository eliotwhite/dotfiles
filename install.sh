#!/bin/bash

echo "Setting up your computer..."

# .make.sh
# Create symlinks from the home directory to any desired dotfiles in ~/dotfiles

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig gitignore_global mackup.cfg zprofile zshrc"    # list of files/folders to symlink in homedir

##########

# Install zsh and oh my zsh. Doing this first so config files aren't later overwritten
# by this function.

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is MacOS, tell the user to install zsh :) (but it should already be installed)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script."
        exit
    fi
fi
}

install_zsh

# Now we clone the powerlevel10k repository so we can use that as a theme
git clone https://github.com/romkatv/powerlevel10k.git $dir/omz-custom/themes/powerlevel10k

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install different software depending on the platform defined earlier ($platform)
# If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            brew install git gh tree wget yt-dlp
        fi
    # If the platform is MacOS, install all our dependencies with bundle (See Brewfile)
    elif [[ $platform == 'Darwin' ]]; then
        brew tap homebrew/bundle
        brew bundle
    fi

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# from the homedir to any files in the ~/.dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Create a Sites directory
# This is an default directory for OS X user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Set OS X preferences
# We will run this last because this will reload the shell
# source .osx