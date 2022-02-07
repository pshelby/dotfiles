#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#brew install coreutils

# Install some other useful utilities like `sponge`.
#brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
#brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
#brew install bash
#brew install bash-completion2

# Switch to using brew-installed bash as default shell
#if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
#  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
#  chsh -s /usr/local/bin/bash;
#fi;

# Install `wget` with IRI support.
#brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
#brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
#brew install grep
#brew install openssh
#brew install screen
#brew install homebrew/php/php56 --with-gmp

# Install font tools.
#brew tap bramstein/webfonttools
#brew install sfnt2woff
#brew install sfnt2woff-zopfli
#brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
#brew install aircrack-ng
#brew install bfg
#brew install binutils
#brew install binwalk
#brew install cifer
#brew install dex2jar
#brew install dns2tcp
#brew install fcrackzip
#brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
#brew install netpbm
#brew install nmap
#brew install pngcheck
#brew install socat
#brew install sqlmap
#brew install tcpflow
#brew install tcpreplay
#brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install xpdf
#brew install xz

# Install other useful binaries.
#brew install ack
##brew install exiv2
#brew install git
#brew install git-lfs
#brew install imagemagick --with-webp
#brew install lua
#brew install lynx
#brew install p7zip
#brew install pigz
brew install pstree
#brew install pv
#brew install rename
#brew install rlwrap
#brew install ssh-copy-id
brew install tree
#brew install vbindiff
#brew install zopfli

# pshelby - Install other useful binaries.
brew install argocd
#brew install aws-cdk
brew install aws-iam-authenticator
brew install awscli
brew install awslogs
brew install certbot
brew install cruft
brew install dive
brew install drone-cli
brew install helm
brew install jq
brew install kubernetes-cli
brew install kustomize
brew install ncurses
brew install nektos/act
brew install podman
brew install poetry
brew install pre-commit
brew install python@3.8
brew install python@3.9
brew install python@3.10
brew install rust
brew install starship
brew install terraform
brew install tmux
brew install tox
brew install vault
brew install zsh
brew install zsh-completions

# pshelby - Install useful applications
brew install --cask 1password
brew install --cask 1password-cli
brew install --cask aws-vault
#brew install --cask datagrip
brew install --cask docker
brew install --cask fantastical
brew install --cask font-meslo-for-powerline
#brew install --cask intel-power-gadget
brew install --cask istat-menus
brew install --cask iterm2
brew install --cask lens
brew install --cask muzzle
brew install --cask nordvpn
brew install --cask obs
brew install --cask obsidian
brew install --cask postman
brew install --cask rectangle
brew install --cask slack
brew install --cask visual-studio-code
#brew install --cask vmware-horizon-client
brew install --cask wireshark

# Remove outdated versions from the cellar.
brew cleanup
