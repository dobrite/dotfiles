# Alias definitions.
# put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# API keys, specific computer stuff (work vs. personal)
if [ -f ~/.env ]; then
  . ~/.env
fi

if [ -f ~/git-completion.bash ]; then
  . ~/git-completion.bash
fi

export VISUAL=vim
export EDITOR=$VISUAL

# Prompt
git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "${ref#refs/heads/}"
  else
    echo '::'
  fi
}

current_path() {
  user=$(whoami)
  echo $(pwd | sed "s|/Users/${user}|~|")
}

ruby_version() {
  echo $(rbenv version | sed "s/ .*//")
}

PROMPT_PREFIX='[\[$(tput setaf 7)\]\[$(tput bold)\]$(ruby_version)\[$(tput sgr0)\]]'
PROMPT_PATH='[\[$(tput setaf 4)\]$(current_path)\[$(tput sgr0)\]]'
PROMPT_SUFFIX='\[$(tput bold)\]$\[$(tput sgr0)\] '
PROMPT_GIT_BRANCH='[\[$(tput setaf 7)\]$(git_branch)\[$(tput sgr0)\]]'
PROMPT_TIME='[\[$(tput setaf 2)\]\D{%F}\[$(tput sgr0)\]\[$(tput setaf 3)\] \D{%T}\[$(tput sgr0)\]]'

export PS1="\n$PROMPT_TIME$PROMPT_PREFIX$PROMPT_GIT_BRANCH\n$PROMPT_PATH \n$PROMPT_SUFFIX"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export GOPATH=$HOME/projects/go
export PATH="$PATH:$GOPATH/bin"

# rust stuffs
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$DYLD_LIBRARY_PATH

export NVM_DIR="/Users/dave/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export RUST_NEW_ERROR_FORMAT=true
eval "$(direnv hook bash)"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -s "/Users/dave/.scm_breeze/scm_breeze.sh" ] && source "/Users/dave/.scm_breeze/scm_breeze.sh"
