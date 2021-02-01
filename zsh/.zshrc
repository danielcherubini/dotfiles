# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="spaceship"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bower npm nvm node docker zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER=daniel
USER=daniel
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

export co="$HOME/Coding"

bindkey -e
bindkey '^[C' forward-word
bindkey '^[D' backward-word

export PATH="$PATH:$HOME/.activator/bin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

unsetopt share_history
setopt no_share_history

SPACESHIP_USER_SHOW=false


if [ "$(uname)" = "Linux" ]; then
	source /usr/share/nvm/init-nvm.sh
	export GOROOT="/usr/lib/go"
else
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	export GOROOT="/usr/local/opt/go/libexec"
	autoload -U add-zsh-hook
	load-nvmrc() {
	  local node_version="$(nvm version)"
	  local nvmrc_path="$(nvm_find_nvmrc)"

	  if [ -n "$nvmrc_path" ]; then
	    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

	    if [ "$nvmrc_node_version" = "N/A" ]; then
	      nvm install
	    elif [ "$nvmrc_node_version" != "$node_version" ]; then
	      nvm use
	    fi
	  elif [ "$node_version" != "$(nvm version default)" ]; then
	    echo "Reverting to nvm default version"
	    nvm use default
	  fi
	}
	# add-zsh-hook chpwd load-nvmrc
	# load-nvmrc

	# alias python=/usr/local/bin/python3
fi

export GOPATH="$HOME/.go:$HOME/Coding/Go"
export GO111MODULE="on"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$HOME/.go/bin"

export PATH="$HOME/.cargo/bin:$PATH"

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export LDFLAGS="-L/usr/local/opt/gettext/lib"

export CPPFLAGS="-I/usr/local/opt/gettext/include"
alias tf=terraform

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/daniel/Coding/DNB/consent-management-service/node_modules/tabtab/.completions/slss.zsh

alias gproxy='ssh -f -nNT gitproxy'
alias gproxy-status='ssh -O check gitproxy'
alias gproxy-off='ssh -O exit gitproxy'

export PATH="$HOME/.local/bin:$PATH"

autoload -Uz compinit
compinit
# Completion for kitty
# kitty + complete setup zsh | source /dev/stdin

# alias tmux="env TERM=screen-256color tmux -2"

eval "$(starship init zsh)"
