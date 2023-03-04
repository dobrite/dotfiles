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

# work specific stuff
if [ -f ~/.work.sh ]; then
  . ~/.work.sh
fi

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

export VISUAL=nvim
export EDITOR=$VISUAL

# Prompt
git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null
}

current_path() {
  pwd | sed "s|/Users/${whoami}|~|"
}

ruby_version() {
  rbenv version | sed "s/ .*//"
}

NEWLINE=$'\n'
PROMPT_TIME='[%F{green}%D%F{yellow} %T%F{grey}]'
setopt PROMPT_SUBST
export PROMPT='${NEWLINE}$PROMPT_TIME [%F{white}$(ruby_version)%F{grey}] [%F{white}$(git_branch)%F{grey}]${NEWLINE}[%F{blue}%~%F{grey}] ${NEWLINE}%F{blue}~%F{grey} 🐟 '

export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

source "$HOME/.cargo/env"

source "$HOME/.asdf/asdf.sh"

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

export RBENV_ROOT=$HOME/.rbenv
eval "$(rbenv init - zsh)"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
