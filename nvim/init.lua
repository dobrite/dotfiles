vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local utils = require 'utils'

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'tpope/vim-rails',

  -- MixedCase (crm) camelCase (crc) UPPER_CASE (cru) dash-case (cr-) dot.case (cr.)
  'tpope/vim-abolish',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing!
      'simrat39/rust-tools.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'petertriho/cmp-git',
      'ray-x/cmp-treesitter',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- toggle term
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    -- cmd = { 'ToggleTerm', 'TermExec' },
    -- keys = { '<C-Bslash>' },
    config = function()
      require('toggleterm').setup {
        open_mapping = '<C-Bslash>',
        direction = 'float',
      }
    end,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- next chunk
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })
        -- prev chunk
        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = '[g]it [s]tage hunk' })
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = '[g]it [r]eset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = '[g]it [S]tage buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[g]it [u]ndo stage hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = '[g]it [R]eset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = '[g]it [p]review hunk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = '[g]it [b]lame line' })
        map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[g]it [t]oggle current line [b]lame' })
        map('n', '<leader>gd', gs.diffthis, { desc = '[g]it [d]iff this' })
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { desc = '[g]it [D]iff this ~' })
        map('n', '<leader>gtd', gs.toggle_deleted, { desc = '[g]it [t]oggle [d]eleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },

  {
    'andrewferrier/wrapping.nvim',
    config = true,
    ft = { 'markdown', 'gitcommit', 'text' },
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    'janko-m/vim-test',
    config = function()
      vim.g['test#strategy'] = 'basic'
      vim.api.nvim_set_keymap('n', ',N', ':TestNearest<CR>', { silent = true, desc = 'test [N]earest' })
      vim.api.nvim_set_keymap('n', ',F', ':TestFile<CR>', { silent = true, desc = 'test [F]ile' })
      vim.api.nvim_set_keymap('n', ',A', ':TestSuite<CR>', { silent = true, desc = 'test [S]uite' })
      vim.api.nvim_set_keymap('n', ',L', ':TestLast<CR>', { silent = true, desc = 'test [L]ast' })
      vim.api.nvim_set_keymap('n', ',V', ':TestVisit<CR>', { silent = true, desc = 'test [V]isit' })
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
      },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- :Z command for cd-ing into folders (see :help zoxide)
  {
    'nanotee/zoxide.vim',
    dependencies = {
      -- for latest run :call fzf#install()
      'junegunn/fzf',
    },
  },

  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  { 'lunarmodules/luafilesystem' },
  { 'slim-template/vim-slim' },

  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },

  { 'echasnovski/mini.icons', version = false },

  {
    'stevearc/conform.nvim',
    opts = {},
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = { file_types = { 'markdown', 'copilot-chat' } },
  },

  { 'github/copilot.vim' },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'gemini-2.5-pro-preview-06-05',
      mappings = {
        submit_prompt = {
          normal = '<C-s>',
          insert = '<C-s>',
        },
        reset = {
          normal = '<C-r>',
          insert = '<C-r>',
        },
      },
      prompts = {
        SecondOpinion = {
          context = 'git:staged',
          prompt = [[
            How does this as a solution?

            Can you think of anything simpler, or more idiomatic?
            Can you think of any edge cases that this solution does not handle?
          ]],
        },
        RSpec = {
          prompt = [[
            Please generate rspec tests for my code using the following guidelines:

            Add `require "rails_helper"` to the top of the file.
            Single space
            Use a top-level `describe ClassName` block to wrap the tests rather than `RSpec.describe`

            Prefer using named subjects, if possible: `subject(:my_subject) { ... }`
            Prefer using `super()` in child contexts, if possible. Do not use named subjects in child contexts as they're not supported.
            Prefer using shorthand `it { is_expected.to ... }` syntax.
            Strongly prefer one expect per test.
            Do not test private methods or explicitly call out private methods in the tests.
            Only use comments when absolutely necessary.

            ## Currents

            `Organization` and `Person` both have a `.current` method that returns the current instance of the class.
            `Organization.current` is aleady set in global RSpec setup. There is no need to set it.
            If needed for the test, add `let(:organization) { Organization.current }`
            Use `organization` rather than `Organization.current` in the tests.

            ## Redis

            * Redis is set up and available to use.
            * Prefer using directly in unit tests for code that directly interact with Redis.
              * If Redis is used, be sure to clean up after the test in an after block.
            * Prefer stubbing collaborator methods in unit tests for code that indirectly interacts with Redis.

            ## Time handling

            Prefer using `ActiveSupport::Testing::TimeHelpers` over `Timecop`.
            If used, ensure to clean up after the test in an after block.

            ## Formatting

            Prefer using `{ }` for short blocks and `do ... end` for blocks that span multiple lines.

            Make the order:

            1) any `let`s
            2) `subject`
            3) `before` block
            4) `after` block (if needed)
          ]],
        },
      },
      contexts = {
        file = {
          input = function(callback)
            local telescope = require 'telescope.builtin'
            local actions = require 'telescope.actions'
            local action_state = require 'telescope.actions.state'
            telescope.find_files {
              attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  callback(selection[1])
                end)
                return true
              end,
            }
          end,
        },
      },
    },
  },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
-- vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Disble mouse mode
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('mini.icons').setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        height = 0.95,
        width = 0.95,
        mirror = true,
        preview_height = 0.35,
        prompt_position = 'top',
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        'rg',
        '--files',
        '--hidden',
        '--no-ignore-vcs',
        '--glob',
        '!**/.git/*',
        '--glob',
        '!**/node_modules/*',
        '--glob',
        '!**/.devbox/virtenv/*',
        '--glob',
        '!**/tmp/*',
        '--glob',
        '!**public/uploads/*',
      },
    },
    live_grep = {
      additional_args = function()
        return {
          '--sort-files',
          '--hidden',
          '--glob',
          '!**/.git/*',
          '--glob',
          '!**/node_modules/*',
          '--glob',
          '!**/.devbox/virtenv/*',
          '--glob',
          '!**/tmp/*',
          '--glob',
          '!**public/uploads/*',
        }
      end,
    },
    buffers = {
      show_all_buffers = false,
      sort_mru = true,
      mappings = {
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
        },
        n = {
          ['<c-d>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
        },
      },
    },
  },
  extensions = {
    zoxide = {
      prompt_title = '[ Zoxide List ]',
      list_command = 'zoxide query -ls',
      mappings = {
        default = {
          action = function(selection)
            vim.cmd.edit(selection.path)
          end,
          after_action = function(selection)
            print('Directory changed to ' .. selection.path)
          end,
        },
        ['<C-s>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command 'split' },
        ['<C-v>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command 'vsplit' },
        ['<C-e>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command 'edit' },
        ['<C-b>'] = {
          keepinsert = true,
          action = function(selection)
            require('telescope.builtin').file_browser { cwd = selection.path }
          end,
        },
        ['<C-f>'] = {
          keepinsert = true,
          action = function(selection)
            require('telescope.builtin').find_files { cwd = selection.path }
          end,
        },
        ['<C-t>'] = {
          action = function(selection)
            vim.cmd.tcd(selection.path)
          end,
        },
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
-- Enable zoxide, if installed
pcall(require('telescope').load_extension 'zoxide')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sc', require('telescope.builtin').command_history, { desc = '[S]earch [C]ommand' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', ',a', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>cd', require('telescope').extensions.zoxide.list, { desc = '[C]hange [D]irectory' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c',
    'cpp',
    'diff',
    'go',
    'html',
    'javascript',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'ruby',
    'rust',
    'scss',
    'tsx',
    'typescript',
    'vim',
  },

  auto_install = false,
  sync_install = false,
  ignore_install = {},

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = { enable = false },
  },
}

-- folding via treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99
-- end folding

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  if client.name == 'rust_analyzer' then
    vim.keymap.set('n', '<leader>rd', '<cmd>RustDebuggables<cr>', { desc = '[R]ust [D]ebug' })
    vim.keymap.set('n', '<leader>rm', require('rust-tools').expand_macro.expand_macro, { desc = '[R]ust [M]acro expand' })
    vim.keymap.set('n', '<leader>rha', require('rust-tools').hover_actions.hover_actions, { desc = '[R]ust [H]over [A]ctions', buffer = bufnr })
    vim.keymap.set('n', '<leader>rca', require('rust-tools').code_action_group.code_action_group, { desc = '[R]ust [C]ode [A]ctions', buffer = bufnr })
  end

  local wamLspAutocmdsGrp = vim.api.nvim_create_augroup('WamLspAutocmds', {})
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      buffer = bufnr,
      group = wamLspAutocmdsGrp,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      buffer = bufnr,
      group = wamLspAutocmdsGrp,
    })
  end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  harper_ls = {},
  clangd = {},
  pyright = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = 'none',
          reportMissingImports = 'none',
        },
      },
    },
  },
  ts_ls = {},
  -- rust_analyzer setup via rust-tools (see mason_lspconfig.setup_handlers)
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
  ['rust_analyzer'] = function()
    require('rust-tools').setup {
      tools = {
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = '',
          other_hints_prefix = '',
        },
      },
      server = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
              allTargets = true,
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
              attributes = {
                enable = true,
              },
            },
          },
        },
      },
    }
  end,
}

-- mason auto-update
require('mason-tool-installer').setup {
  ensure_installed = {
    'commitlint',
    -- 'codespell',
    'prettierd',
    'eslint_d',
    -- 'selene',
    -- 'shellcheck', -- used by bash-language-server
    'stylua',
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 5000,
}

require('lspconfig').ruby_lsp.setup {
  mason = false,
  capabilities = capabilities,
  on_attach = on_attach,
  --  init_options = {
  --    formatter = 'standard',
  --    linters = { 'standard' },
  --  },
  settings = {},
  filetypes = { 'ruby', 'eruby' },
}

require('lspconfig').harper_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  -- added javascriptreact
  filetypes = {
    'c',
    'cpp',
    'cs',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'javascriptreact',
    'lua',
    'markdown',
    'nix',
    'python',
    'ruby',
    'rust',
    'swift',
    'toml',
    'typescript',
    'typescriptreact',
  },
  settings = {
    ['harper-ls'] = {
      linters = {
        sentence_capitalization = false,
      },
      codeActions = {
        forceStable = true,
      },
    },
  },
}

if utils.installed_via_bundler 'syntax_tree' then
  require('lspconfig').syntax_tree.setup {
    cmd = { 'bundle', 'exec', 'stree', 'lsp' },
  }
end

if utils.installed_via_bundler 'solargraph' then
  require('lspconfig').solargraph.setup {
    cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
    init_options = {
      formatting = false,
    },
    settings = {
      solargraph = {
        diagnostics = true,
        logLevel = 'debug',
      },
    },
    commands = {
      SolargraphDocumentGems = {
        function()
          vim.lsp.buf_notify(0, '$/solargraph/documentGems', {})
        end,
        description = 'Build YARD documentation for installed gems',
      },
      SolargraphDocumentGemsWithRebuild = {
        function()
          vim.lsp.buf_notify(0, '$/solargraph/documentGems', { rebuild = true })
        end,
        description = 'Build YARD documentation for installed gems',
      },
      SolargraphCheckGemVersion = {
        function()
          vim.lsp.buf_notify(0, '$/solargraph/checkGemVersion', { verbose = true })
        end,
        description = 'Check if a newer version of the gem is available',
      },
      SolargraphRestartServer = {
        function()
          vim.lsp.buf_notify(0, '$/solargraph/restartServer', {})
        end,
        description = 'A notification sent from the server to the client requesting that the client shut down and restart the server',
      },
    },
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  formatting = {
    format = lspkind.cmp_format { mode = 'symbol_text' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'render-markdown' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'treesitter' },
    { name = 'buffer' },
    { name = 'spell', keyword_length = 4 },
  },
}

cmp.setup.filetype('text', {
  sources = cmp.config.sources {
    { name = 'spell', keyword_length = 3 },
  },
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources {
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'git_handles', priority = 10 },
    { name = 'git', priority = 9 },
    { name = 'spell', keyword_length = 4 },
  },
})

vim.g.lazygit_floating_window_scaling_factor = 1.0
vim.g.lazygit_floating_window_use_plenary = 0 -- otherwise key shortcut footer is missing
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

-- AI stuffs
vim.g.copilot_no_tab_map = true
vim.g.copilot_node_command = '~/.asdf/installs/nodejs/23.1.0/bin/node'
vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.keymap.set('i', '<C-c>a', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_workspace_folders = { vim.fn.fnamemodify(vim.fn.system 'git rev-parse --show-toplevel', ':p:h') }
local chat = require 'CopilotChat'
local actions = require 'CopilotChat.actions'
-- local integration = require 'CopilotChat.integrations.fzflua'
local group = vim.api.nvim_create_augroup('NeoVimRc', { clear = true })

require('which-key').add { '<leader>a', group = 'AI' }

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})

vim.keymap.set({ 'n' }, '<leader>aa', chat.toggle, { desc = 'AI Toggle' })
vim.keymap.set({ 'v' }, '<leader>aa', chat.open, { desc = 'AI Open' })
vim.keymap.set({ 'n' }, '<leader>ax', chat.reset, { desc = 'AI Reset' })
vim.keymap.set({ 'n' }, '<leader>as', chat.stop, { desc = 'AI Stop' })
vim.keymap.set({ 'n' }, '<leader>am', chat.select_model, { desc = 'AI Model' })
--vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
--  integration.pick(actions.prompt_actions(), {
--    fzf_tmux_opts = {
--      ['-d'] = '45%',
--    },
--  })
--end, { desc = 'AI Prompts' })
vim.keymap.set({ 'n', 'v' }, '<leader>aq', function()
  vim.ui.input({
    prompt = 'AI Question> ',
  }, function(input)
    if input and input ~= '' then
      chat.ask(input)
    end
  end)
end, { desc = 'AI Question' })
-- End AI stuffs

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- python = { 'isort', 'black' },
    ruby = (function()
      local formatters = {}
      if utils.installed_via_bundler 'syntax_tree' then
        table.insert(formatters, 'syntax_tree')
      end
      if utils.rubocop_version_doesnt_hose_everything() then
        table.insert(formatters, 'rubocop')
      end
      return formatters
    end)(),
    rust = { 'rustfmt', lsp_format = 'fallback' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 10000,
    lsp_format = 'fallback',
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
