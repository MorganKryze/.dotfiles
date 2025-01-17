# Display system information using neofetch
fastfetch -c ~/.config/fastfetch/config.jsonc -l nix

# Initialize starship
eval "$(starship init zsh)"

# Zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autopair/autopair.zsh

# Load the commands prefixes
source ~/.dotfiles/dependencies/bash-toolbox/src/prefix.sh

# Raspberry Pi Wizard executable
source /Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard/src/rpi-wizard.sh
export RPI_SETUP_WIZARD_PATH=/Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.1/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# Ignore sha request
function zshaddhistory() {
    [[ $1 == shasum* || $1 == hash* ]] && return 1
    return 0
}