#!/usr/bin/env zsh

# @raycast.schemaVersion 1
# @raycast.title PR review
# @raycast.mode compact
# @raycast.packageName GitHub
# @raycast.icon 🔍
# @raycast.description Open a herdr workspace and start a Claude review of a GitHub PR
# @raycast.argument1 { "type": "text", "placeholder": "PR URL, or empty for clipboard", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Extra instructions", "optional": true }

export PATH="$HOME/dotfiles/bin:$HOME/.local/bin:/opt/homebrew/bin:$PATH"

local input="$1" extra="$2" source="argument"
if [[ -z "${input// /}" ]]; then
  input="$(pbpaste)"
  source="clipboard"
fi
input="${input//[[:space:]]/}"

if [[ ! "$input" =~ '^https?://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)' ]]; then
  if [[ "$source" == clipboard ]]; then
    echo "Clipboard has no GitHub PR URL." >&2
  else
    echo "Not a GitHub PR URL." >&2
  fi
  exit 1
fi

local owner="$match[1]" repo="$match[2]" pr_number="$match[3]"
local url="https://github.com/$owner/$repo/pull/$pr_number"

if [[ ! -d "$HOME/Code/$repo" ]]; then
  echo "~/Code/$repo does not exist" >&2
  exit 1
fi

if ! herdr status server 2>/dev/null | grep -q '^status: running$'; then
  echo "herdr server is not running. Open Ghostty first." >&2
  exit 1
fi

if [[ -n "${extra// /}" ]]; then
  pr-review "$url" "$extra" || exit $?
else
  pr-review "$url" || exit $?
fi

open -a Ghostty
