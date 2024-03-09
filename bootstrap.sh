#!/bin/zsh

# If not installed, install brew
if ! command -v brew &> /dev/null
then
    echo "Brew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# If not installed, install git
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Installing..."
    brew install git
fi


# Update to latest .dotfiles version
git pull origin main

# Install Homebrew packages
sh brew.sh

# Add symlinks to the home directory
source ./symlinks.sh
add_symlink