# Display system information using neofetch
fastfetch -c ~/.config/fastfetch/config.jsonc -l nix

# Zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autopair/autopair.zsh

# Load the commands prefixes
source ~/.dotfiles/dependencies/bash-toolbox/src/prefix.sh

# Raspberry Pi Wizard executable
source /Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard/src/rpi-wizard.sh
export RPI_SETUP_WIZARD_PATH=/Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard
