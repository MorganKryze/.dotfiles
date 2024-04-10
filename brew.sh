#!/bin/zsh

########################################################################################
# General Homebrew
########################################################################################

# Update Homebrew to the latest version
echo "Updating Homebrew."
brew update
brew upgrade

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install other useful binaries.
brew install nmap
brew install wget
brew install curl
brew install p7zip
brew install poppler
brew install java
brew install pkg-config
brew install graphviz

########################################################################################
# Terminal
########################################################################################

read -p "Do you want to install Terminal tools? (y/n): " dev_tools </dev/tty
if [[ $dev_tools == "y" || $dev_tools == "Y" || $dev_tools == "" ]]; then
    echo "Installing Terminal tools."
    brew install neofetch
    brew install lsd
    brew install z
    brew install htop
    brew install btop
    brew install codewhisperer
else
    echo "Skipping developer tools..."
fi

########################################################################################
# Docker
########################################################################################

read -p "Do you want to install Docker? (y/n): " docker_tools </dev/tty
if [[ $docker_tools == "y" || $docker_tools == "Y" || $docker_tools == "" ]]; then
    echo "Installing Docker."
    brew install docker
    brew install lazydocker
else
    echo "Skipping Docker..."
fi

########################################################################################
# Virtualization
########################################################################################

read -p "Do you want to install Virtualization tools? (y/n): " virt_tools </dev/tty
if [[ $virt_tools == "y" || $virt_tools == "Y" || $virt_tools == "" ]]; then
    echo "Installing Virtualization tools."
    brew install utm
    brew install crystalfetch
else
    echo "Skipping virtualization tools..."
fi

########################################################################################
# Security
########################################################################################

read -p "Do you want to install security tools? (y/n): " security_tools </dev/tty
if [[ $security_tools == "y" || $security_tools == "Y" || $security_tools == "" ]]; then
    echo "Installing Security tools."
    brew install bitwarden
    brew install clamav
    brew install veracrypt
    brew install lulu
    brew install oversight
    brew install knockknock
    brew install blockblock
    brew install reikey
    brew install protonvpn
else
    echo "Skipping security tools..."
fi

########################################################################################
# Browsers
########################################################################################

read -p "Do you want to install browser tools? (y/n): " browser_tools </dev/tty
if [[ $browser_tools == "y" || $browser_tools == "Y" || $browser_tools == "" ]]; then
    echo "Installing Browsers."
    brew install arc
    brew install brave-browser
    brew install tor-browser
    brew install google-chrome
else
    echo "Skipping browser tools..."
fi

########################################################################################
# Productivity
########################################################################################

read -p "Do you want to install Productivity tools? (y/n): " prod_tools </dev/tty
if [[ $prod_tools == "y" || $prod_tools == "Y" || $prod_tools == "" ]]; then
    echo "Installing Productivity tools."
    brew install raycast
    brew install maccy
    brew install notion
    brew install pomatez
    brew install cheatsheet
else
    echo "Skipping Productivity tools..."
fi

########################################################################################
# Photo & Video
########################################################################################

read -p "Do you want to install Photo & Video tools? (y/n): " media_tools </dev/tty
if [[ $media_tools == "y" || $media_tools == "Y" || $media_tools == "" ]]; then
    echo "Installing Photo & Video tools."
    brew install imageoptim
    brew install vlc
    brew install drawio
    brew install inkscape
    brew install canva
    brew install flameshot
else
    echo "Skipping Photo & Video tools..."
fi

########################################################################################
# Messaging
########################################################################################

read -p "Do you want to install Messaging tools? (y/n): " mess_tools </dev/tty
if [[ $mess_tools == "y" || $mess_tools == "Y" || $mess_tools == "" ]]; then
    echo "Installing Messaging tools."
    brew install thunderbird
    brew install signal
    brew install discord
else
    echo "Skipping messaging tools..."
fi

########################################################################################
# Utility
########################################################################################

read -p "Do you want to install Utility tools? (y/n): " util_tools </dev/tty
if [[ $util_tools == "y" || $util_tools == "Y" || $util_tools == "" ]]; then
    echo "Installing Utility tools."
    brew install onyx
    brew install appcleaner
    brew install the-unarchiver
    brew install iina
    brew install stats
    brew install devtoys
    brew install keyboardcleantool
    brew install mediamate
    brew install lunar
    brew install transmission
else
    echo "Skipping utility tools..."
fi

########################################################################################
# Gaming
########################################################################################

read -p "Do you want to install Gaming tools? (y/n): " games_tools </dev/tty
if [[ $games_tools == "y" || $games_tools == "Y" || $games_tools == "" ]]; then
    echo "Installing Games."
    brew install steam
    brew install openemu
    brew install cmatrix
else
    echo "Skipping gaming tools..."
fi

# Remove outdated versions from the cellar.
brew autoremove
brew cleanup

echo "Homebrew packages installed and cleaned!"
