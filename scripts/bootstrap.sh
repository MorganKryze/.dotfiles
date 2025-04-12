source <(curl -s https://raw.githubusercontent.com/MorganKryze/bash-toolbox/main/src/prefix.sh)

info "[1/6] Updating the hostname..."
NEW_HOSTNAME="concord"
CURRENT_HOSTNAME=$(scutil --get HostName)
if [ "$CURRENT_HOSTNAME" != "$NEW_HOSTNAME" ]; then
    sudo scutil --set HostName "$NEW_HOSTNAME" || error "Failed to set HostName." || return 1
    sudo scutil --set LocalHostName "$NEW_HOSTNAME" || error "Failed to set LocalHostName." || return 1
    sudo scutil --set ComputerName "$NEW_HOSTNAME" || error "Failed to set ComputerName." || return 1
    dscacheutil -flushcache || error "Failed to flush DNS cache." || return 1
else
    warning "Hostname is already set to $NEW_HOSTNAME."
fi

info "[2/6] Installing Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
    warning "Xcode Command Line Tools are already installed."
else
    info "Installing Xcode Command Line Tools..."
    xcode-select --install || error "Failed to install Xcode Command Line Tools." || return 1
    acknoledge "Download the Xcode Command Line Tools from the pop-up window before continuing."
fi

info "[3/6] Installing Rosetta..."
if [ "$(uname -m)" = "arm64" ]; then
    if /usr/bin/pgrep oahd >/dev/null 2>&1; then
        warning "Rosetta is already installed."
    else
        softwareupdate --install-rosetta --agree-to-license || error "Failed to install Rosetta." || return 1
    fi
else
    warning "Rosetta is not required on this machine."
fi

info "[4/6] Fetching the .dotfiles from GitHub..."
if [ -d "$HOME/.dotfiles" ]; then
    info "Pulling the latest version of .dotfiles..."
    cd "$HOME/.dotfiles" || error "Failed to change directory to $HOME/.dotfiles." || return 1
    git pull origin main || error "Failed to pull the latest version of .dotfiles." || return 1
    git submodule update --init --recursive || error "Failed to update the submodules." || return 1
else
    info "Cloning the .dotfiles repository..."
    git clone --recurse-submodules https://github.com/MorganKryze/.dotfiles.git "$HOME/.dotfiles" || error "Failed to clone the .dotfiles repository." || return 1
    cd "$HOME/.dotfiles" || error "Failed to change directory to $HOME/.dotfiles." || return 1
fi

info "[5/6] Installing Nix..."
if ! command -v nix &>/dev/null; then
    sh <(curl -L https://nixos.org/nix/install) || error "Failed to install Nix." || return 1
    acknoledge "Nix has successfully been installed. Start a new terminal window and run again 'curl -s https://raw.githubusercontent.com/MorganKryze/.dotfiles/main/scripts/bootstrap.sh | zsh'"
elif ! command -v brew &>/dev/null; then
    info "[6/6] Nix is already installed. Proceeding to the config setup..."
    nix run nix-darwin --experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles#concord --impure || error "Failed to setup the Concord flake." || return 1
    success "Bootstrap completed successfully. Your system is now ready to use. Enjoy! :3"
else
    info "[6/6] Nix and Nix-Darwin are already installed. Rebuilding the environment..."
    darwin-rebuild switch --flake ~/.dotfiles#concord --impure || error "Failed to rebuild the environment." || return 1
    success "Your system is now up-to-date. Enjoy! :3"
fi
