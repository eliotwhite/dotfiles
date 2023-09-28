#!/bin/bash

echo "Setting up your computer..."

# .make.sh
# Create symlinks from the home directory to any desired dotfiles in ~/dotfiles

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig gitignore_global mackup.cfg zshrc"    # list of files/folders to symlink in homedir

########## Installing Oh My Zsh and zsh itself

# Install zsh and oh my zsh. Doing this first so config files aren't later overwritten
# by this function.

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Install oh-my-zsh only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        echo "\033[0;31m*** Installing Oh My Zsh. After this runs, type 'exit' at the prompt to continue installation. ***"
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
            sudo apt-get update
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


########## Installing Homebrew

# Before we install Homebrew, we need to know the architecture of the system we're 
# attempting to install it on. At the time of writing, Homebrew isn't supported on ARM 
# Linux systems.
architecture=$(arch);
platform=$(uname);
# If we're on Linux and ARM architecture, skip installing homebrew.
if [[ $platform == 'Linux' && $architecture == 'aarch64' ]]; then
    echo "Homebrew is not currently supported on ARM Linux."
else
    # Check for Homebrew and install if we don't have it
    if test ! $(which brew); then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # If the platform is Linux, add homebrew's path to your zsh profile.
    if [[ $platform == 'Linux' ]]; then
        (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.zprofile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # If the platform is MacOS, add homebrew's path to your zsh profile. However, the 
    # profile is different depending on whether you're on Apple Silicon or Intel.
    elif [[ $platform == 'Darwin' ]]; then
        if [[ $architecture == 'arm64' ]]; then
            (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ $architecture == 'i386' ]]; then
            (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> $HOME/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo "This platform ($platform on $architecture) is unknown to homebrew. You may need to take other steps to make Homebrew available from zsh."
    fi
    
    # Update Homebrew recipes.
    brew update
    
    # Install different homebrew software depending on the platform defined earlier. 
    # If the platform is Linux, install these specific brews.
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install build-essential
        brew install gcc git gh tree wget yt-dlp
    # If the platform is MacOS, install all our dependencies with bundle (See Brewfile).
    elif [[ $platform == 'Darwin' ]]; then
        brew tap homebrew/bundle
        brew bundle
    fi
fi

########## Deal with dotfiles and other setup preferences

# Create dotfiles_old in homedir.
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# Change to the dotfiles directory.
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# from the homedir to any files in the ~/.dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    # Check whether the dotfile exists.
	if [ -e ~/.$file ]; then
        # If the dotfile exists, move it to the dotfiles_old directory.
        echo "Backing up .$file."
        mv ~/.$file ~/dotfiles_old/
    else
        # If the dotfile doesn't exist, skip the backup and move to the next one.
        echo ".$file does not exist. Skipping backup."
    fi
    # Make a symlink to the dotfile from the corresponding file in the dotfiles directory.
    echo "Creating symlink to .$file in home directory."
    ln -s $dir/$file ~/.$file
done

# Create a Sites directory
# This is an default directory for OS X user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Set OS X preferences
# We will run this last because this will reload the shell
# source .osx