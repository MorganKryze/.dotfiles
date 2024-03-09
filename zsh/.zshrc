#!/bin/zsh

# Clear the terminal screen
clear && printf '\e[3J'

# Set oh-my-zsh theme and plugins
ZSH_THEME="bira"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Source the oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# Display system information using neofetch
neofetch