source ~/.dotfiles/dependencies/bash-toolbox/src/prefix.sh

create_symlinks() {
    info "This function will add symlinks to the home directory."

    info "Adding Git symlinks..."
    [ ! -L ~/.gitconfig ] && ln -s ~/.dotfiles/apps/git/.gitconfig ~/.gitconfig || warning ".gitconfig already exists!"
    [ ! -L ~/.git_func ] && ln -s ~/.dotfiles/apps/git/.git_func ~/.git_func || warning ".git_func already exists!"
    if [ ! -d ~/.gitemojis ]; then
        mkdir ~/.gitemojis
    fi
    [ ! -L ~/.gitemojis/commit-msg ] && ln -s ~/.dotfiles/apps/git/gitemojis/commit-msg ~/.gitemojis/commit-msg || warning ".gitemojis/commit-msg already exists!"
    [ ! -L ~/.gitemojis/prepare-commit-msg ] && ln -s ~/.dotfiles/apps/git/gitemojis/prepare-commit-msg ~/.gitemojis/prepare-commit-msg || warning ".gitemojis/prepare-commit-msg already exists!"

    info "Adding Zsh symlinks..."
    [ ! -L ~/.zshrc ] && ln -s ~/.dotfiles/apps/zsh/.zshrc ~/.zshrc || warning ".zshrc already exists!"
    [ ! -L ~/.zshenv ] && ln -s ~/.dotfiles/apps/zsh/.zshenv ~/.zshenv || warning ".zshenv already exists!"
    [ ! -L ~/.zprofile ] && ln -s ~/.dotfiles/apps/zsh/.zprofile ~/.zprofile || warning ".zprofile already exists!"

    [ ! -L ~/.exports ] && ln -s ~/.dotfiles/apps/zsh/.exports ~/.exports || warning ".exports already exists!"
    [ ! -L ~/.aliases ] && ln -s ~/.dotfiles/apps/zsh/.aliases ~/.aliases || warning ".aliases already exists!"
    [ ! -L ~/.functions ] && ln -s ~/.dotfiles/apps/zsh/.functions ~/.functions || warning ".functions already exists!"

    info "Adding Yabai symlinks..."
    [ ! -L ~/.yabairc ] && ln -s ~/.dotfiles/apps/yabai/.yabairc ~/.yabairc || warning ".yabairc already exists!"
    [ ! -L ~/.skhdrc ] && ln -s ~/.dotfiles/apps/yabai/.skhdrc ~/.skhdrc || warning ".skhdrc already exists!"
    [ ! -L ~/.yabai_func ] && ln -s ~/.dotfiles/apps/yabai/.yabai_func ~/.yabai_func || warning ".yabai_func already exists!"

    info "Adding Conda symlinks..."
    [ ! -L ~/.condarc ] && ln -s ~/.dotfiles/apps/conda/.condarc ~/.condarc || warning ".condarc already exists!"
    [ ! -L ~/.conda_func ] && ln -s ~/.dotfiles/apps/conda/.conda_func ~/.conda_func || warning ".conda_func already exists!"

    info "Adding VsCode symlinks..."
    ln -sf ~/.dotfiles/apps/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -sf ~/.dotfiles/apps/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

    info "Adding last symlinks..."
    [ ! -L ~/.hushlogin ] && ln -s ~/.dotfiles/docs/assets/.hushlogin ~/.hushlogin || warning ".hushlogin already exists!"
    [ ! -L ~/.curlrc ] && ln -s ~/.dotfiles/apps/curl/.curlrc ~/.curlrc || warning ".curlrc already exists!"

    success "Symlinks added successfully!"
}

remove_symlinks() {
    info "Removing symlinks..."

    info "Removing Git symlinks..."
    [ -L ~/.gitconfig ] && rm ~/.gitconfig
    [ -L ~/.git_func ] && rm ~/.git_func
    [ -L ~/.gitemojis/commit-msg ] && rm ~/.gitemojis/commit-msg
    [ -L ~/.gitemojis/prepare-commit-msg ] && rm ~/.gitemojis/prepare-commit-msg

    info "Removing Zsh symlinks..."
    [ -L ~/.zshrc ] && rm ~/.zshrc
    [ -L ~/.zshenv ] && rm ~/.zshenv
    [ -L ~/.zprofile ] && rm ~/.zprofile

    [ -L ~/.exports ] && rm ~/.exports
    [ -L ~/.aliases ] && rm ~/.aliases
    [ -L ~/.functions ] && rm ~/.functions

    info "Removing Yabai symlinks..."
    [ -L ~/.yabairc ] && rm ~/.yabairc
    [ -L ~/.skhdrc ] && rm ~/.skhdrc
    [ -L ~/.yabai_func ] && rm ~/.yabai_func

    info "Removing Conda symlinks..."
    [ -L ~/.condarc ] && rm ~/.condarc
    [ -L ~/.conda_func ] && rm ~/.conda_func

    info "Removing VsCode symlinks..."
    [ -L ~/Library/Application\ Support/Code/User/settings.json ] && rm ~/Library/Application\ Support/Code/User/settings.json
    [ -L ~/Library/Application\ Support/Code/User/keybindings.json ] && rm ~/Library/Application\ Support/Code/User/keybindings.json

    info "Removing last symlinks..."
    [ -L ~/.hushlogin ] && rm ~/.hushlogin
    [ -L ~/.curlrc ] && rm ~/.curlrc

    success "Symlinks removed successfully!"
}
