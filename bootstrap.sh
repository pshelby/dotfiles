#!/usr/bin/env zsh

function copy_files() {
	rsync -ahnv --no-perms \
    --exclude-from "copy-excludes.txt" \
		. ~;
	source ~/.zshrc;
}

function install_homebrew_formulae() {
	read -k 1 \?"Do you want to install all Homebrew formulae in brew.sh? [y|N] " ;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./brew.sh
	fi;
}

# Move to root git dir for this repo
SCRIPT_PATH="${0:A:h}"
cd $SCRIPT_PATH

# Pull latest changes
git pull origin main;

# Copy files into home dir
if [ "$1" = "--force" -o "$1" = "-f" ]; then
	copy_files;
else
	read -k 1 \?"This may overwrite existing files in your home directory. Are you sure? [y|N] " ;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copy_files;
	fi;
fi;

# Homebrew install
if [ ! $(which brew) ]; then
	read -k 1 \?"Cannot find Homebrew.  Do you want to install it? [y|N] " ;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
		install_homebrew_formulae;
	fi
else
	install_homebrew_formulae;
fi

# zsh shell change
read -k 1 \?"Install OhMyZsh (changes default shell to zsh)? [y|N] " ;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi;

# zsh plugins
read -k 1 \?"Install custom ZSH plugins? [y|N] ";
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	shared/zsh-plugins.sh
fi;

# Cleanup variables
unset copy_files;
unset install_homerew_formulae;
