# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# EXPORTS
# NODE
export NPM_PACKAGES="${HOME}/.npm"
export PATH="${NPM_PACKAGES}/bin:${PATH}"
export PATH="/home/alex/.gem/ruby/2.5.0/bin:${PATH}"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sublime z git-flow)

source $ZSH/oh-my-zsh.sh

# User configuration
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zshconfig="nano ~/.zshrc"
alias getssh="cat ~/.ssh/id_rsa.pub"
alias sshtf="ssh alex@134.60.70.82"
alias yclean="yaourt -Qdt && yaourt -Scc"
alias yupdate="yaourt -Syua"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if ! [ -x "$(command -v colorls)" ]; then
    alias ls=' ls'
    alias l = ' ls -la'
else
    alias ls=' colorls'
    alias l=' colorls -la'
fi
