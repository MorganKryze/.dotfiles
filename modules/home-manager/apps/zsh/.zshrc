# Display system information using neofetch
fastfetch -c $HOME/.config/fastfetch/config.jsonc -l nix

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


# Raspberry Pi Wizard executable
source /Users/morgan/Documents/00-local/01-git/01-morgankryze/RaspberryPi-Setup-Wizard/src/rpi-wizard.sh
export RPI_SETUP_WIZARD_PATH=/Users/morgan/Documents/00-local/01-git/01-morgankryze/RaspberryPi-Setup-Wizard

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.1/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# Ignore sha request
function zshaddhistory() {
    [[ $1 == shasum* || $1 == hash* ]] && return 1
    return 0
}