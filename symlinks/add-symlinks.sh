echo "Adding symlinks..."
# Git
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/.git_func ~/.git_func
# checj if gitemojis folder exists
if [ ! -d ~/.gitemojis ]; then
    mkdir ~/.gitemojis
fi
ln -s ~/.dotfiles/git/gitemojis/commit-msg ~/.gitemojis/commit-msg
ln -s ~/.dotfiles/git/gitemojis/prepare-commit-msg ~/.gitemojis/prepare-commit-msg

# Zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/.dotfiles/zsh/.zprofile ~/.zprofile

ln -s ~/.dotfiles/zsh/.exports ~/.exports
ln -s ~/.dotfiles/zsh/.aliases ~/.aliases
ln -s ~/.dotfiles/zsh/.functions ~/.functions

# Yabai
ln -s ~/.dotfiles/yabai/.yabairc ~/.yabairc
ln -s ~/.dotfiles/yabai/.skhdrc ~/.skhdrc
ln -s ~/.dotfiles/yabai/.yabai_func ~/.yabai_func

# Conda
ln -s ~/.dotfiles/conda/.condarc ~/.condarc
ln -s ~/.dotfiles/conda/.conda_func ~/.conda_func

# Huslogin
ln -s ~/.dotfiles/.hushlogin ~/.hushlogin

# Curl
ln -s ~/.dotfiles/.curlrc ~/.curlrc

# VsCode
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

echo "Symlinks added!"
