# The zprofile file is sourced by zsh for login shells. This file is used to set 
# environment variables, shell options, and run commands that should be executed only 
# in the login shell. This file is read by zsh every time a new shell is started, so it 
# is a good place to put environment variables that 
# should be set for every shell session.

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
