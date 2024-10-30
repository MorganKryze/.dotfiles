# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Q pre block. Keep at the top of this file.

# Clear the terminal screen
#clear && printf '\e[3J'

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

# Q post block. Keep at the bottom of this file.
PATH="/Users/yannvidamment/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/yannvidamment/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/yannvidamment/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/yannvidamment/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/yannvidamment/perl5"; export PERL_MM_OPT;

# Raspberry Pi Wizard executable
source /Users/yannvidamment/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard/src/rpi-wizard.sh
export RPI_SETUP_WIZARD_PATH=/Users/yannvidamment/Documents/02-dev/02-git/01-morgankryze/RaspberryPi-Setup-Wizard

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# bun completions
[ -s "/Users/yannvidamment/.bun/_bun" ] && source "/Users/yannvidamment/.bun/_bun"

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.1/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)
