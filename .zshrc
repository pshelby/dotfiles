### Prerequisites:
#   * Homebrew
#   * Oh My Zsh
#   * Python

### User binaries
export PATH="$PATH:$HOME/.local/bin"

### Homebrew
export HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)
export PATH=$HOMEBREW_PREFIX/opt/python/libexec/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/bin:$PATH

### Rust
export PATH=$HOME/.cargo/bin:$PATH
export RUSTC_WRAPPER=sccache

### Neovim AI plugins
# Created at https://console.anthropic.com/settings/keys (Tatari Google login)
export AVANTE_ANTHROPIC_API_KEY=$(cat ~/.anthropic-api-key)
export AVANTE_GITHUB_API_KEY=$(cat ~/.github-token-avante)
# Created at https://platform.openai.com/settings/organization/api-keys (personal login)
export AVANTE_OPENAI_API_KEY=$(cat ~/.openai-api-key)
# Created at kagi.com
export KAGI_API_KEY=$(cat ~/.kagi-api-key)

### Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
  jira
  tmux
  vi-mode
  # zsh-autosuggestions
  zsh-syntax-highlighting
)

# Init plugins if exists
if [ -f ~/.zsh-plugins.sh ]; then
  ~/.zsh-plugins.sh
fi

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
alias ls=eza
alias lst="eza -alT -I .git"
alias rg="rg --follow -i --hidden -g \!.git"
alias vim=nvim

# Functions
av() {
  aws-vault exec ${AV_ENV:-"main"} -- $@
}

avl() {
  aws-vault login ${AV_ENV:-"main"}
}

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
  if command -v wormhole &> /dev/null; then
    echo "Sending password via magic-wormhole"
    echo "https://magic-wormhole.readthedocs.io/en/latest/"
    wormhole send --text $RANDOM_PSWD
  fi
}

tf() {
  AV_ENV=${AV_ENV:-"main"} av terraform $@
}

tfa() {
  tf apply $@
}

tfi() {
  tf init $@
}

tfp() {
  # Pattern to exclude for slimmer output
  # ' Read|Refreshing state|^(Acquiring|Releasing|Terraform has compared)'
  tf plan $@
}

# Starship prompt
# Configuration: https://starship.rs/config/
eval "$(starship init zsh)"

### Current company-specific items can be added below
