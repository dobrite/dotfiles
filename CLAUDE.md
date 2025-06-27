# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository containing configuration files for a development environment. The repository manages shell configuration, git settings, and symbolic links to various tools and configurations.

## Installation Commands

**Setup dotfiles:**
```bash
# Create necessary directories
mkdir -p ~/.githooks

# Create symbolic links
ln -s $HOME/dotfiles/.gitconfig ~/.gitconfig
ln -s $HOME/dotfiles/pre-push ~/.githooks/pre-push
ln -s $HOME/dotfiles/.zprofile ~/.zprofile
ln -s $HOME/dotfiles/.gitattributes ~/.gitattributes
ln -s $HOME/dotfiles/direnv.toml ~/.config/direnv/direnv.toml
ln -s $HOME/dotfiles/ghostty-config ~/.config/ghostty/config
ln -s $HOME/dotfiles/.irbrc ~/.irbrc

# Install custom git commands
ln -s $HOME/dotfiles/bin/git-delete-local-merged /usr/local/bin
ln -s $HOME/dotfiles/bin/git-super-prune /usr/local/bin
ln -s $HOME/dotfiles/bin/timey.rb /usr/local/bin

# Setup additional dotfiles (run load.sh for more)
./load.sh
```

**Testing setup:**
```bash
# Test git configuration
git config --get user.name

# Test custom git commands
git delete-local-merged
git super-prune

# Test shell configuration
echo $VISUAL  # Should be nvim
```

## Architecture

**Core Structure:**
- Shell configuration (`.zshrc`, `.zprofile`, `.aliases`)
- Git configuration (`.gitconfig`, git hooks, custom commands)
- Development tools configuration (Neovim, direnv, ghostty)
- Custom utility scripts in `bin/`

**Key Components:**

**Shell Configuration:**
- `.zshrc` - Main ZSH configuration with custom prompt, functions, and tool integrations
- Custom prompt showing time, Ruby/Node versions, devbox status, git branch, and random emoji
- Integrations: asdf, zoxide, scmpuff, direnv, atuin, fzf
- Functions: `repo()` (open git remote), `git_branch()`, version checkers

**Git Configuration:**
- `.gitconfig` - Git settings and aliases
- `pre-push` hook - Prevents pushing to main branch (configurable with `hooks.allowpushmain`)
- Custom commands:
  - `git-delete-local-merged` - Deletes local branches merged into HEAD
  - `git-super-prune` - Combines delete-local-merged with remote prune

**Development Tools:**
- Neovim configuration in `nvim/` directory (has its own CLAUDE.md)
- Ghostty terminal configuration
- direnv configuration for project-specific environments
- IRB configuration for Ruby development

**Environment Management:**
- Support for asdf version manager (Ruby, Node.js)
- Devbox integration with visual indicators
- Cargo/Rust toolchain support
- Android SDK path configuration
- Homebrew integration (both Intel and Apple Silicon)

**Version Display:**
- Ruby version via devbox or asdf
- Node.js version via devbox or asdf
- Devbox status indicator in prompt
- Git branch display in prompt

## Important Files

- `.zshrc` - Main shell configuration with custom prompt and tool integrations
- `.gitconfig` - Git settings and aliases
- `pre-push` - Git hook preventing accidental pushes to main
- `load.sh` - Script to create additional symbolic links
- `bin/` - Custom utility scripts for git workflow
- `nvim/` - Neovim configuration (separate CLAUDE.md exists)