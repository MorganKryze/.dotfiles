source ~/.dotfiles/dependencies/bash-toolbox/src/prefix.sh
source ~/.dotfiles/.env

info "This script will set up a new SSH key pair for GitHub."

info "Generating SSH key..."
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/git -p "" || error "Failed to generate SSH key." 

info "Starting the ssh-agent..."
eval "$(ssh-agent -s)" || error "Failed to start the ssh-agent."

info "Adding the SSH key to the ssh-agent..."
echo "Host github.com
  IPreferredAuthentications publickey
  IdentityFile ~/.ssh/git" > ~/.ssh/config || error "Failed to write SSH config."

info "Adding the SSH key to the ssh-agent..."
ssh-add ~/.ssh/git || error "Failed to add SSH key to the ssh-agent."

info "Copying the SSH key to the clipboard..."
pbcopy < ~/.ssh/git.pub || error "Failed to copy SSH key to clipboard."

info "The SSH key has been copied to the clipboard. Please add it to your GitHub account."
open "https://github.com/settings/keys" || error "Failed to open GitHub keys page."

success "SSH key has been set up successfully."