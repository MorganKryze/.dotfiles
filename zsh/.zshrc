clear && printf '\e[3J'

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