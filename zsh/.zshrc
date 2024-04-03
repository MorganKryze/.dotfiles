# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
#!/bin/zsh

# Clear the terminal screen
clear && printf '\e[3J'

# Set oh-my-zsh theme and plugins
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

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
