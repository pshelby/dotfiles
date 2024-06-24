### Prerequisites:
#   * Homebrew
#   * Oh My Zsh
#   * Python

### User binaries
export PATH="$PATH:$HOME/.local/bin"

### Homebrew
export HOMEBREW_PREFIX=$(brew --prefix)
export PATH=$HOMEBREW_PREFIX/opt/python/libexec/bin:$HOMEBREW_PREFIX/sbin:$PATH

### Rust
export PATH=$HOME/.cargo/bin:$PATH
export RUSTC_WRAPPER=sccache

### Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Enable command auto-correction.
#ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Start tmux on terminal start
ZSH_TMUX_AUTOSTART=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  vi-mode
  zsh-syntax-highlighting
)

# Init plugins
.zsh-plugins.sh

# Activate!
source $ZSH/oh-my-zsh.sh

### User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias fd="fd --ignore-case --hidden --no-ignore"
alias grpo="git remote prune origin"
alias ls=exa
alias lst="exa -alT -I .git"
alias rg="rg -i --hidden -g \!.git"
alias vim=nvim

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

gls() {
  for f in $(git ls-files); do
    git --no-pager log --color -1 --date=short --pretty=format:'%C(cyan)%ai%Creset' -- $f;
    echo  " $f";
  done | sort -r
}

# Convert JSON to YAML
json2yaml() {
  python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < $1 > $2
}

random-pswd() {
  LENGTH="${1:-24}"
  RANDOM_PSWD=$(head /dev/urandom | LC_ALL=C tr -d -c A-Za-z0-9 | head -c$LENGTH)
  echo $RANDOM_PSWD
  echo "https://magic-wormhole.readthedocs.io/en/latest/"
  wormhole send --text $RANDOM_PSWD
}

vault-list() {
  ~/.vault-list.sh $@
}

# Starship prompt
# Configuration: https://starship.rs/config/
eval "$(starship init zsh)"

### Current company-specific items
