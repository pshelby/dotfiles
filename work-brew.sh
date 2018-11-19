#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
#brew install grep
#brew install openssh

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install nmap

# Install other useful binaries.
brew install git
brew install ssh-copy-id
brew install tree

# Work related items
brew install ansible
brew install awscli
brew install cntlm
brew install gdbm
brew install go
brew install jq
brew install kompose
brew install libevent
brew install libyaml
brew install mysql@5.7
brew install oniguruma
brew install openshift-cli
brew install openssl
brew install openssl@1.1
brew install perl
brew install python
brew install python@2
brew install readline
brew install ruby
brew install saml2aws
brew install screenfetch
brew install socat
brew install sqlite
brew install terraform
brew install tmux
brew install utf8proc
brew install xz

# Work apps
brew cask install atom
brew cask install flux
brew cask install istat-menus
brew cask install java
brew cask install microsoft-remote-desktop-beta
#brew cask install slack
brew cask install spectacle
brew cask install vagrant
#brew cask install virtualbox
#brew cask install visual-studio-code
brew cask install visualvm

# Remove outdated versions from the cellar.
brew cleanup
