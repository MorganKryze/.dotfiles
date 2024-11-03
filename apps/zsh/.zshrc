# # Set oh-my-zsh theme and plugins
# ZSH_THEME="bira"
# plugins=(
#     git
#     zsh-autosuggestions
#     zsh-syntax-highlighting
# )

# # Source the oh-my-zsh script
# source $ZSH/oh-my-zsh.sh

# Display system information using neofetch
neofetch

eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Raspberry Pi Wizard executable
source /Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard/src/rpi-wizard.sh
export RPI_SETUP_WIZARD_PATH=/Users/morgan/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.1/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)
