#!/usr/bin/env bash

function copy_files() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

function install_homebrew_formulae() {
	read -p "Do you want to install all Homebrew formulae in brew.sh? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./brew.sh
	fi;
}

# Move to root git dir for this repo
cd "$(dirname "${BASH_SOURCE}")";

# Pull latest changes
git pull origin master;

# Copy files into home dir
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copy_files;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copy_files;
	fi;
fi;

# Homebrew install
if [ ! $(which brew) ]; then
	read -p "Cannot find Homebrew.  Do you want to install it? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
		install_homebrew_formulae;
	fi
else
	install_homebrew_formulae;
fi

# zsh shell change
read -p "Install OhMyZsh (changes default shell to zsh)? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi;

# Cleanup variables
unset copy_files;
