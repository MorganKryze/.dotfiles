# Display system information using fastfetch
fastfetch -c $HOME/.config/fastfetch/config.jsonc -l NixOS

# Load the commands prefixes
source $HOME/.dotfiles/dependencies/bash-toolbox/src/prefix.sh

# Check for last update of the system
nix-update-check

# Initialize starship
eval "$(starship init zsh)"

# Zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autopair/autopair.zsh

# Ignore sha request
function zshaddhistory() {
    [[ $1 == shasum* || $1 == hash* || $1 == shash* ]] && return 1
    return 0
}

