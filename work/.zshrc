# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/pshelby/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="random"
# ZSH_THEME="spaceship"

# Spaceship theme customization
SPACESHIP_PROMPT_ORDER=(
  #time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  #exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  #vi_mode       # Vi-mode indicator
  #jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  time          # Time stamps section
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
)
SPACESHIP_PROMPT_ADD_NEWLINE=false   # Adds a newline character before each prompt line
SPACESHIP_PROMPT_SEPARATE_LINE=false # Make the prompt span across two lines
SPACESHIP_TIME_SHOW=true             # Show time (set to true for enabling)
SPACESHIP_EXEC_TIME_ELAPSED=0        # The minimum number of seconds for showing execution time section
SPACESHIP_EXIT_CODE_SHOW=true        # Show exit code of last command
SPACESHIP_KUBECTL_SHOW=true          # Show time (set to true for enabling)
SPACESHIP_KUBECTL_VERSION_SHOW=false # Do not show the k8s version

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "wezm+" "gianu" "obraun" "tonotdo" "lukerandall" "jispwoso" "gallois" "norm" "robbyrussell" "agnoster" "smt" "re5et" )
# Multiline
# ZSH_THEME_RANDOM_CANDIDATES=( "mortalscumbag" "dieter" "ys" "steeef" "refined" "strug" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# tmux settings
ZSH_TMUX_AUTOSTART=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias grpo="git remote prune origin"
alias tf="terraform"
alias tfa="terraform apply"
alias tfi="terraform init"
alias tfp="terraform plan"

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
  SECRET_KEY=$(curl -s -d "secret=${RANDOM_PSWD}" https://onetimesecret.com/api/v1/share | jq -r '.secret_key')
  echo "https://onetimesecret.com/secret/${SECRET_KEY}"
}

# Starship prompt
# Configuration: https://starship.rs/config/
eval "$(starship init zsh)"

# Current company-specific items can be added below
