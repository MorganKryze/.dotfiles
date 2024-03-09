#!/bin/zsh

# Update Homebrew to the latest version
echo "Updating Homebrew."
brew update
brew upgrade

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
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
brew install unrar

read - r miniconda"?Do you want to set up Miniconda? (y/n): " </dev/tty
if [[ $miniconda == "y" || $miniconda == "Y" || $miniconda == "" ]]; then
    echo "Installing Miniconda."
    brew install miniconda
    conda init "$(basename "${SHELL}")"
else
    echo "Skipping Miniconda..."
fi

read -r docker_tools"?Do you want to install Docker? (y/n): " </dev/tty
if [[ $docker_tools == "y" || $docker_tools == "Y" || $docker_tools == "" ]]; then
    echo "Installing Docker."
    brew install docker
    brew install lazydocker
else
    echo "Skipping Docker..."
fi

read -r security_tools"?Do you want to install security tools? (y/n): " </dev/tty
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

read -r browser_tools"?Do you want to install browser tools? (y/n): " </dev/tty
if [[ $browser_tools == "y" || $browser_tools == "Y" || $browser_tools == "" ]]; then
    echo "Installing Browsers."
    brew install arc
    brew install brave-browser
    brew install tor-browser
else
    echo "Skipping browser tools..."
fi

read -r productivity_tools"?Do you want to install Productivity tools? (y/n): " </dev/tty
if [[ $productivity_tools == "y" || $productivity_tools == "Y" || $productivity_tools == "" ]]; then
    echo "Installing Productivity tools."
    brew install raycast
    brew install maccy
    brew install notion
    brew install pomatez
    brew install rectangle
    brew install cheatsheet
else
    echo "Skipping Productivity tools..."
fi

read -r media_tools"?Do you want to install Photo & Video tools? (y/n): " </dev/tty
if [[ $media_tools == "y" || $media_tools == "Y" || $media_tools == "" ]]; then
    echo "Installing Photo & Video tools."
    brew install imageoptim
    brew install vlc
    brew install drawio
    brew install inkscape
    brew install canva
else
    echo "Skipping Photo & Video tools..."
fi

read -r messaging_tools"?Do you want to install Messaging tools? (y/n): " </dev/tty
if [[ $messaging_tools == "y" || $messaging_tools == "Y" || $messaging_tools == "" ]]; then
    echo "Installing Messaging tools."
    brew install thunderbird
    brew install signal
    brew install discord
else
    echo "Skipping messaging tools..."
fi

read -r games_tools"?Do you want to install Gaming tools? (y/n): " </dev/tty
if [[ $games_tools == "y" || $games_tools == "Y" || $games_tools == "" ]]; then
    echo "Installing Games."
    brew install steam
    brew install openemu
    brew install cmatrix
else
    echo "Skipping gaming tools..."
fi

read -r dev_tools"?Do you want to install Terminal tools? (y/n): " </dev/tty
if [[ $dev_tools == "y" || $dev_tools == "Y" || $dev_tools == "" ]]; then
    echo "Installing Terminal tools."
    brew install neofetch
    brew install lsd
    brew install z
    brew install htop
    brew install btop
else
    echo "Skipping developer tools..."
fi

read -r virtualization_tools"?Do you want to install Virtualization tools? (y/n): " </dev/tty
if [[ $virtualization_tools == "y" || $virtualization_tools == "Y" || $virtualization_tools == "" ]]; then
    echo "Installing Virtualization tools."
    brew install utm
    brew install crystalfetch
else
    echo "Skipping virtualization tools..."
fi

# Remove outdated versions from the cellar.
brew cleanup
brew autoremove

echo "Homebrew packages installed and cleaned!"
