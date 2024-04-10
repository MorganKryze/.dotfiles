echo "Removing symlinks..."
# Git
rm ~/.gitconfig
rm ~/.git_func
rm ~/.gitemojis/commit-msg
rm ~/.gitemojis/prepare-commit-msg

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

# Huslogin
rm ~/.hushlogin

# Curl
rm ~/.curlrc

# VsCode
rm ~/Library/Application\ Support/Code/User/settings.json
rm ~/Library/Application\ Support/Code/User/keybindings.json

# Java
rm /Library/Java/JavaVirtualMachines/openjdk.jdk

echo "Symlinks removed!"
