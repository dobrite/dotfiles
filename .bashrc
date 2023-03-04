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

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
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
PROMPT_SUFFIX='\[$(tput setaf 4)\]~ \[$(tput sgr0)\]\[$(tput setaf 3)\]><>\[$(tput sgr0)\] '
PROMPT_GIT_BRANCH='[\[$(tput setaf 7)\]$(git_branch)\[$(tput sgr0)\]]'
PROMPT_TIME='[\[$(tput setaf 2)\]\D{%F}\[$(tput sgr0)\]\[$(tput setaf 3)\] \D{%T}\[$(tput sgr0)\]]'

export PS1="\n$PROMPT_TIME$PROMPT_PREFIX$PROMPT_GIT_BRANCH\n$PROMPT_PATH \n$PROMPT_SUFFIX"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# rust stuffs
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

export PATH="$HOME/Library/Python/3.8/bin:$PATH"

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
