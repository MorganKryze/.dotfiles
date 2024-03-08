#!/bin/zsh

# Add symlinks to the home directory
function add_symlink() {
    if [[ $1 != '-y' ]] && [[ $1 != '--yes' ]]; then
        read -r add"?Do you want to add symlinks? [Y/n] "
        if [[ $add =~ ^([nN][oO]|[nN])$ ]] || [[ -n $add && $add != 'y' && $add != 'Y' ]]; then
            echo "Skipping symlinks..."
            exit 0
        fi
    fi
    echo "Adding symlinks..."
    # Git
    ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

    # Zsh
    ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
    ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv
    ln -s ~/dotfiles/zsh/.zprofile ~/.zprofile

    ln -s ~/dotfiles/zsh/.exports ~/.exports
    ln -s ~/dotfiles/zsh/.aliases ~/.aliases
    ln -s ~/dotfiles/zsh/.functions ~/.functions

    # Yabai
    ln -s ~/dotfiles/yabai/.yabairc ~/.yabairc
    ln -s ~/dotfiles/yabai/.skhdrc ~/.skhdrc
    ln -s ~/dotfiles/yabai/.yabai_func ~/.yabai_func

    # Conda
    ln -s ~/dotfiles/conda/.condarc ~/.condarc
    ln -s ~/dotfiles/conda/.conda_func ~/.conda_func

    echo "Symlinks added!"
}

# Remove symlinks from the home directory
function remove_symlink() {
    if [[ $1 != '-y' ]] && [[ $1 != '--yes' ]]; then
        read -r remove"?Do you want to remove symlinks? This may delete non-symlink files bearing the same name. [Y/n] "
        if [[ $remove =~ ^([nN][oO]|[nN])$ ]] || [[ -n $remove && $remove != 'y' && $remove != 'Y' ]]; then
            echo "Skipping symlinks removal..."
            exit 0
        fi
    fi
    echo "Removing symlinks..."
    # Git
    rm ~/.gitconfig

    # Zsh
    rm ~/.zshrc
    rm ~/.zshenv
    rm ~/.zprofile

    rm ~/.exports
    rm ~/.aliases
    rm ~/.functions

    # Yabai
    rm ~/.yabairc
    rm ~/.skhdrc
    rm ~/.yabai_func

    # Conda
    rm ~/.condarc
    rm ~/.conda_func

    echo "Symlinks removed!"
}

