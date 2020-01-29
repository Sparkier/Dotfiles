# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# EXPORTS
# NODE
export NPM_PACKAGES="${HOME}/.npm"
export PATH="${NPM_PACKAGES}/bin:${PATH}"
export PATH="/home/alex/.gem/ruby/2.5.0/bin:${PATH}"
# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Set name of the theme to load.
ZSH_THEME="alex"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z git-flow)

source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# User configuration
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zc="vim ~/.zshrc"
alias so="source ~/.zshrc"
alias getssh="cat ~/.ssh/id_rsa.pub"
alias yc="yay -Qdt && yay -Scc"
alias yu="yay -Syua"
alias rf="rm -rf"
alias lc="colorls -lA --sd --gs"
alias ls="colorls"
alias l=lc

# Fuzzy Finder.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function gi() {
   curl -L -s https://www.gitignore.io/api/$@
}

# Use FZF for generating a gitignore file.
function gifzf() {
   local list=$(gi list | tr , '\n' | fzf --multi | tr '\n' , | sed 's/,$//' )
   gi $list
}

# Make directory and cd into it.
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

