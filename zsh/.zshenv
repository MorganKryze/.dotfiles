#!/bin/zsh

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles:
for file in ~/.{exports,aliases,functions,yabai_func}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
