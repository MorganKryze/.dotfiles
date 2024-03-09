source ~/.dotfiles/.env

# Generate SSH key
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL"

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add authorized host
echo "Host github.com
  IgnoreUnknown UseKeychain
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Copy the SSH key to your clipboard
pbcopy < ~/.ssh/id_ed25519.pub

# Open the GitHub settings page
open "https://github.com/settings/keys"