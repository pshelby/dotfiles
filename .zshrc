# Prerequisites:
#   * Homebrew
#   * Oh My Zsh
#   * Python
#   * Magic Wormhole

# Homebrew
export HOMEBREW_PREFIX=$(brew --prefix)
export PATH=$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH

# Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# Path to your oh-my-zsh installation.
export ZSH="/Users/pshelby/.oh-my-zsh"
# Enable command auto-correction.
ENABLE_CORRECTION="true"
# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# Start tmux on terminal start
ZSH_TMUX_AUTOSTART=true
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode zsh-syntax-highlighting)
# Init plugins
.zsh-plugins.sh
# Activate!
source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias grpo="git remote prune origin"

# Functions
brew-recursive-uninstall() {
  FORMULAE_TO_DELETE=$1

  brew leaves > brew-leaves-before.txt

  while [[ -n $FORMULAE_TO_DELETE ]]; do
    brew uninstall $(echo $FORMULAE_TO_DELETE | xargs);
    brew leaves > brew-leaves-after.txt;
    FORMULAE_TO_DELETE=$(comm -13 <(sort -u brew-leaves-before.txt) <(sort -u brew-leaves-after.txt) | tr '\n' ' ');
    mv brew-leaves-after.txt brew-leaves-before.txt;
  done

  rm brew-leaves-*.txt
  unset FORMULAE_TO_DELETE
}

# Convert JSON to YAML
json2yaml() {
  python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < $1 > $2
}

random-pswd() {
  LENGTH="${1:-24}"
  RANDOM_PSWD=$(head /dev/urandom | LC_ALL=C tr -d -c A-Za-z0-9 | head -c$LENGTH)
  echo $RANDOM_PSWD
  wormhole send --text $RANDOM_PSWD
}

vault-list() {
  ~/.vault-list.sh $@
}

# Starship prompt
# Configuration: https://starship.rs/config/
eval "$(starship init zsh)"
