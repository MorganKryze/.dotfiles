# Display system information using neofetch
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


# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.1/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# Ignore sha request
function zshaddhistory() {
    [[ $1 == shasum* || $1 == hash* || $1 == shash* ]] && return 1
    return 0
}

