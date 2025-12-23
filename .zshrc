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

function repo() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    origin_url=$(git remote get-url origin | 
      sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git$//')
    open "$origin_url"
  else
    echo "Not in a git repository. Please provide a repository name."
  fi
}

git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null
}

current_path() {
  pwd | sed "s|/Users/${whoami}|~|"
}

ruby_version() {
  (devbox info ruby 2>/dev/null || asdf current ruby) | head -n1 | awk '{print $2}'
}

node_version() {
  (devbox info nodejs 2>/dev/null || asdf current nodejs) | head -n1 | awk '{print $2}'
}

has_devbox() {
  if [ -f devbox.json ]; then
    echo "%F{cyan}%F{white}"
  fi
}

NEWLINE=$'\n'
PROMPT_TIME='%F{green}%D%F{yellow} %T%F{grey}'
PS1_EMOJIS=("😀" "😃" "😄" "😁" "😆" "😅" "🤣" "😂" "🙂" "🙃" "😉" "😊" "😇" "😍" "😘" "😗" "😚" "😙" "😋" "😛" "😜" "😝" "🤑" "🤗" "🤔" "🤐" "😐" "😑" "😶" "😏" "😒" "🙄" "😬" "🤥" "😌" "😔" "😪" "🤤" "😴" "😷" "🤒" "🤕" "🤢" "🤧" "😵" "🤠" "😎" "🤓" "😕" "😟" "🙁" "😮" "😯" "😲" "😳" "😦" "😧" "😨" "😰" "😥" "😢" "😭" "😱" "😖" "😣" "😞" "😓" "😩" "😫" "😤" "😡" "😠" "😈" "👿" "💀" "💩" "🤡" "👹" "👺" "👻" "👽" "🤖" "😺" "😸" "😹" "😻" "😼" "😽" "🙀" "😿" "😾" "🙈" "🙉" "🙊" "💋" "💌" "💘" "💝" "💖" "💗" "💓" "💞" "💕" "💟" "💔" "💛" "💚" "💙" "💜" "💥" "💫" "💦" "💨" "💬" "💭" "💤" "👋" "🤚" "✋" "🖖" "👌" "🤞" "🤘" "🤙" "👈" "👉" "👆" "🖕" "👇" "👍" "👎" "✊" "👊" "🤛" "🤜" "👏" "🙌" "👐" "🤝" "🙏" "💅" "🤳" "💪" "👂" "👀" "👅" "👄" "👶" "👦" "👧" "👱" "👨" "👱" "👨" "👨" "👨" "👨" "👩" "👱" "👩" "👩" "👩" "👩" "👴" "👵" "🙇" "🙇" "🤦" "🤦" "🤦" "🤷" "🤷" "🤷" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👨" "👩" "👩" "🏃" "🏃" "💃" "🕺" "👯" "👯" "👯" "🤺" "🏇" "🚣" "🚣" "🚣" "🏊" "🏊" "🏊" "🚴" "🚴" "🚴" "🚵" "🚵" "🚵" "🤸" "🤸" "🤸" "🤼" "🤼" "🤼" "🤽" "🤽" "🤽" "🤾" "🤾" "🤾" "🤹" "🤹" "🤹" "🛀" "🛌" "👫" "👬" "💏" "👩" "👨" "👩" "💑" "👩" "👨" "👩" "👪" "👨" "👨" "👨" "👨" "👨" "👨" "👨" "👨" "👨" "👨" "👩" "👩" "👩" "👩" "👩" "👨" "👨" "👨" "👨" "👨" "👩" "👩" "👩" "👩" "👩" "🐵" "🐒" "🦍" "🐕" "🐺" "🦊" "🐱" "🐈" "🦁" "🐯" "🐅" "🐆" "🐴" "🐎" "🦄" "🦌" "🐮" "🐂" "🐄" "🐷" "🐖" "🐗" "🐽" "🐏" "🐑" "🐐" "🐪" "🐫" "🐘" "🦏" "🐭" "🐁" "🐀" "🐹" "🐰" "🐇" "🐻" "🐨" "🐼" "🦃" "🐔" "🐓" "🐣" "🐤" "🐥" "🐦" "🐧" "🦅" "🦆" "🦉" "🐸" "🐊" "🐢" "🦎" "🐍" "🐲" "🐉" "🐳" "🐋" "🐬" "🐟" "🐠" "🐡" "🦈" "🐙" "🐚" "🐌" "🦋" "🐛" "🐝" "🐞" "💐" "🌸" "🌹" "🥀" "🌺" "🌻" "🌼" "🌷" "🍇" "🍈" "🍉" "🍊" "🍋" "🍌" "🍍" "🍎" "🍏" "🍐" "🍑" "🍒" "🍓" "🥝" "🍅" "🥑" "🍆" "🥔" "🥕" "🌽" "🥒" "🥜" "🌰" "🍞" "🥐" "🥖" "🥞" "🍖" "🍗" "🥓" "🍔" "🍟" "🍕" "🌭" "🌮" "🌯" "🥙" "🍳" "🥘" "🍲" "🥗" "🍿" "🍱" "🍘" "🍙" "🍚" "🍛" "🍜" "🍝" "🍠" "🍢" "🍣" "🍤" "🍥" "🍡" "🦀" "🦐" "🦑" "🍦" "🍧" "🍨" "🍩" "🍪" "🎂" "🍰" "🍫" "🍬" "🍭" "🍮" "🍯" "🍼" "🥛" "☕" "🍵" "🍶" "🍾" "🍷" "🍸" "🍹" "🍺" "🍻" "🥂" "🥃" "🌍" "🌎" "🌏" "🗾" "🌋" "🗻" "⛺" "🌁" "🌃" "🌄" "🌅" "🌆" "🌇" "🌉" "🎠" "🎡" "🎢" "💈" "🎪" "🚂" "🚃" "🚄" "🚅" "🚆" "🚇" "🚈" "🚉" "🚊" "🚝" "🚞" "🚋" "🚌" "🚍" "🚎" "🚐" "🚑" "🚒" "🚓" "🚔" "🚕" "🚖" "🚗" "🚘" "🚙" "🚚" "🚛" "🚜" "🛵" "🚏" "⛽" "🚨" "🚥" "🚦" "🛑" "🚧" "⚓" "⛵" "🛶" "🚤" "🚢" "🛫" "🛬" "🚁" "🚟" "🚠" "🚡" "🚀" "⌛" "⏳" "⌚" "⏰" "🕛" "🕧" "🕐" "🕜" "🕑" "🕝" "🕒" "🕞" "🕓" "🕟" "🕔" "🕠" "🕕" "🕡" "🕖" "🕢" "🕗" "🕣" "🕘" "🕤" "🕙" "🕥" "🕚" "🕦" "🌑" "🌒" "🌓" "🌔" "🌕" "🌖" "🌗" "🌘" "🌙" "🌚" "🌛" "🌜" "🌝" "🌞" "🌟" "🌠" "🌌" "🌀" "🌈" "🌂" "☔" "⚡" "🎃" "🎄" "🎆" "🎇" "✨" "🎈" "🎉" "🎊" "🎋" "🎍" "🎎" "🎏" "🎐" "🎑" "🎀" "🎁" "🏆" "🏅" "🥇" "🥈" "🥉" "⚽" "⚾" "🏀" "🏐" "🏈" "🏉" "🎾" "🎳" "🏏" "🏑" "🏒" "🏓" "🏸" "🥊" "🥋" "🥅" "⛳" "🎣" "🎿" "🎯" "🔮" "🎮" "🎰" "🎲" "👓" "👖" "👝" "🎒" "👠" "👡" "👑" "👒" "🎩" "🎓" "📿" "💄" "💍" "💎" "🔈" "🔉" "🔊" "📢" "📣" "📯" "🔔" "🔕" "📻" "🎷" "🎸" "🎹" "🎺" "🎻" "📱" "📲" "📞" "📟" "📠" "🔋" "🔌" "💻" "💽" "💾" "💿" "📀" "🎥" "🎬" "📺" "📷" "📸" "📹" "📼" "🔍" "🔎" "💡" "🔦" "🏮" "📔" "📕" "📖" "📗" "📘" "📙" "📚" "💰" "💸" "🔨" "🔫" "🏹" "🔧" "🔩" "🔬" "🔭" "📡" "🚪" "🚿" "🛁" "🛒")
NUMBER_OF_EMOJIS=${#PS1_EMOJIS[@]}
RUBY="%F{red}%F{white} $(ruby_version)"
NODE="%F{green}%F{white} $(node_version)"
setopt PROMPT_SUBST
export PROMPT='${NEWLINE}$PROMPT_TIME %F{grey}$RUBY $NODE $(has_devbox) ${NEWLINE}%F{red}%F{white} $(git_branch) ${NEWLINE}%F{blue}%~%F{grey} ${NEWLINE}%F{blue}~%F{grey} ${PS1_EMOJIS[$RANDOM % $NUMBER_OF_EMOJIS]} '

export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"

export CARGO_NET_GIT_FETCH_WITH_CLI=true
source "$HOME/.cargo/env"

source ~/.rgz.sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

if [[ -e "/opt/homebrew/bin/brew" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/lib"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf: try one of two locations
if [ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi
if [ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]; then
  . "/usr/local/opt/asdf/libexec/asdf.sh"
fi

# z binary (better than cd)
eval "$(zoxide init zsh)"

# like scm_breeze but devbox compatible
eval "$(scmpuff init -s)"

# direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

echo ""
echo "\033[38;5;173m ██████╗  █████╗ ██╗   ██╗███████╗\033[0m"
echo "\033[38;5;173m ██╔══██╗██╔══██╗██║   ██║██╔════╝\033[0m"
echo "\033[38;5;173m ██║  ██║███████║██║   ██║█████╗\033[0m"
echo "\033[38;5;173m ██║  ██║██╔══██║╚██╗ ██╔╝██╔══╝\033[0m"
echo "\033[38;5;173m ██████╔╝██║  ██║ ╚████╔╝ ███████╗\033[0m"
echo "\033[38;5;173m ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚══════╝\033[0m"
echo ""
echo "\033[38;5;173m  ██████╗ ██████╗ ██████╗ ███████╗\033[0m"
echo "\033[38;5;173m ██╔════╝██╔═══██╗██╔══██╗██╔════╝\033[0m"
echo "\033[38;5;173m ██║     ██║   ██║██║  ██║█████╗\033[0m"
echo "\033[38;5;173m ██║     ██║   ██║██║  ██║██╔══╝\033[0m"
echo "\033[38;5;173m ╚██████╗╚██████╔╝██████╔╝███████╗\033[0m"
echo "\033[38;5;173m  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝\033[0m"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
