#!/usr/bin/env zsh

# Install command-line tools using Homebrew

# Update to latest Homebrew
brew update

# Upgrade any existing formulae
brew upgrade

# Networking/Sec tools
brew install nmap
brew install sqlmap

# Other tools
brew install asciinema
brew install awscli
brew install bat
brew install btop
brew install dive
brew install dust
brew install exa
brew install fd
brew install gh
brew install jq
brew install magic-wormhole
brew install neovim
brew install poetry
brew install pstree
brew install python
brew install pyyaml
brew install ripgrep
brew install rust
brew install sd
brew install sqlite
brew install starship
brew install terraform
brew install tmux
brew install tokei
brew install tree
brew install zsh
brew install zsh-completions

# Applications
brew install --cask 1password
brew install --cask 1password-cli
brew install --cask aws-vault
brew install --cask balenaetcher
brew install --cask docker
brew install --cask fantastical
brew install --cask font-meslo-lg-nerd-font
brew install --cask horos
brew install --cask istat-menus
brew install --cask iterm2
brew install --cask ngrok
brew install --cask nordvpn
brew install --cask obs
brew install --cask obsidian
brew install --cask orion
brew install --cask postman
brew install --cask rectangle
brew install --cask shottr
brew install --cask visual-studio-code

# Work tools
brew install act
brew install argocd
brew install aws-iam-authenticator
brew install certbot
brew install cookiecutter
brew install cruft
brew install helm
brew install k9s
brew install kind
brew install kubebuilder
brew install kubernetes-cli
brew install kustomize
brew install ncurses
brew install onefetch
brew install postgresql@14
brew install pre-commit
brew install turbolift
brew install vault

# Work apps
brew install --cask brave-browser
brew install --cask google-cloud-sdk
brew install --cask pgadmin4
brew install --cask slack

# Remove outdated versions from the cellar.
brew cleanup
