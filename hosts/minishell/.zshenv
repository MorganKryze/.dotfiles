# Load the shell dotfiles:
for file in ~/.{aliases,git_func}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
