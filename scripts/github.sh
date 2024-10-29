source ~/.dotfiles/bash-toolbox/
source ~/.dotfiles/.env

# Generate SSH key
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/git -p ""

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add authorized host
echo "Host github.com
  IPreferredAuthentications publickey
  IdentityFile ~/.ssh/git" > ~/.ssh/config

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain
ssh-add --apple-use-keychain ~/.ssh/git

# Copy the SSH key to your clipboard
pbcopy < ~/.ssh/git.pub

# Open the GitHub settings page
open "https://github.com/settings/keys"