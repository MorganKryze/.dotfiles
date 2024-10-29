#!/bin/zsh

# Add default macOS settings
sh .macos

# If not installed, install brew
if ! command -v brew &>/dev/null; then
    echo "Brew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# If not installed, install git
if ! command -v git &>/dev/null; then
    echo "Git is not installed. Installing..."
    brew install git
    brew install git-lfs
fi

# If not installed, install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh my zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# If not installed, install VSCode
if ! command -v code &>/dev/null; then
    echo "VSCode is not installed. Installing..."
    brew install visual-studio-code
fi

# Update to latest .dotfiles version
git pull origin main

# Install Homebrew packages
sh brew.sh

# Add symlinks to the home directory
sh symlinks/add-symlinks.sh

# Install miniconda
source ./conda/.conda_func
env-install

# Install yabai and start the services (remember to disable the SIP)
source ./yabai/.yabai_func
yabai-install

# Set up GitHub for this machine
sh github.sh
