# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Environment

This is a personal Neovim configuration using Lazy.nvim as the package manager. The configuration is written in Lua and follows a modular structure. Requires Neovim 0.11+.

## Commands

Since this is a Neovim configuration, there are no traditional build/test/lint commands. The configuration is loaded when Neovim starts.

**Testing the configuration:**
```bash
nvim --version  # Verify Neovim is installed (0.11+ required)
nvim            # Start Neovim to test the configuration
```

**Plugin management:**
- `:Lazy` - Open Lazy.nvim package manager interface
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Mason` - Open Mason LSP manager
- `:MasonUpdate` - Update all Mason-managed tools

**LSP and Formatting:**
- `:Format` - Format current buffer with LSP
- `:LspRestart` - Restart LSP server
- Mason auto-installs: stylua, prettierd, eslint_d, commitlint

**Linting:**
- `<leader>ln` - Show running linters
- `<leader>li` - LSP Info
- `<leader>lf` - Format buffer
- `<leader>lr` - Restart LSP

## Architecture

**Core Structure:**
- `init.lua` - Main configuration entry point that sets up Lazy.nvim and loads all plugins
- `lua/utils.lua` - Utility functions for Ruby/Rails development (gem detection, version checking)
- `lua/custom/plugins/` - Custom plugin configurations
- `after/plugin/defaults.lua` - Additional vim settings and key mappings loaded after plugins

**Key Components:**

**Plugin Management:**
- Uses Lazy.nvim for plugin management with lazy loading
- Plugins are configured directly in init.lua with inline configurations
- Lock file (`lazy-lock.json`) tracks exact plugin versions

**LSP Configuration:**
- Uses Neovim 0.11 native `vim.lsp.config()` for server setup
- Mason.nvim automatically installs LSP servers
- Configured servers: harper_ls, clangd, pyright, ts_ls, lua_ls, ruby_lsp, solargraph, syntax_tree
- Custom Ruby LSP setup with bundler detection via utils.lua
- Rust support via rust-tools.nvim with clippy integration

**Linting and Formatting:**
- nvim-lint for real-time diagnostics (replaces archived null-ls)
- Configured linters: eslint_d (JS/TS), ruff (Python), commitlint (git), rubocop (Ruby)
- conform.nvim for code formatting
- RuboCop autofix runs automatically on save for Ruby files
- Custom rubocop_bundler linter uses `bundle exec` when available

**Diagnostics:**
- Virtual text enabled with custom formatting
- Severity sorting and enhanced floating diagnostics
- Real-time linting on file changes and save

**AI Integration:**
- GitHub Copilot with custom node path configuration
- CopilotChat with Gemini 2.5 Pro model
- Custom prompts for SecondOpinion and RSpec test generation
- File selection integration with Telescope

**Testing:**
- vim-test plugin with custom key mappings (,N, ,F, ,A, ,L, ,V)
- Strategy set to 'basic' for test execution

**Ruby/Rails Specific:**
- utils.lua provides bundler integration for detecting gems like syntax_tree, solargraph, rubocop
- Conditional LSP setup based on gem availability
- RSpec-specific AI prompts with Rails conventions
- vim-rails plugin for Rails navigation
- Automatic RuboCop autofix on save for Ruby files in projects with Gemfile

**Key Mappings:**
- Leader key: Space
- Telescope: `<C-p>` (find files), `,a` (live grep), `<leader>cd` (zoxide)
- Git: `<leader>gg` (LazyGit), various gitsigns mappings
- AI: `<leader>aa` (toggle chat), `<leader>aq` (quick question)
- Terminal: `<C-\>` (toggle terminal)
- Linting: `<leader>ln` (show linters), `<leader>li` (LSP info), `<leader>lf` (format), `<leader>lr` (restart LSP)

## Important Files

- `init.lua` - Contains all plugin configurations and LSP setup
- `lua/utils.lua` - Ruby/Rails utility functions for LSP conditional loading
- `lazy-lock.json` - Plugin version lock file (do not modify manually)