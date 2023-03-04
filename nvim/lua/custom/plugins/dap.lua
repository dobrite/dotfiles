-- dap.lua
--
-- shows how to use the dap plugin to debug your code.
--
-- primarily focused on configuring the debugger for go, but can
-- be extended to other languages as well. that's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

-- also look at https://github.com/wassimk/dotfiles/blob/main/config/nvim/after/plugin/dap.lua

return {
  -- note: yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- note: and you can specify dependencies as well
  dependencies = {
    -- creates a beautiful debugger ui
    'rcarriga/nvim-dap-ui',

    -- installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- you'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- you can provide additional configuration to the handlers,
    -- see mason-nvim-dap readme for more information
    require('mason-nvim-dap').setup_handlers()

    -- basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<f5>', dap.continue)
    vim.keymap.set('n', '<f1>', dap.step_into)
    vim.keymap.set('n', '<f2>', dap.step_over)
    vim.keymap.set('n', '<f3>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>b', function()
      dap.set_breakpoint(vim.fn.input 'breakpoint condition: ')
    end)

    -- dap ui setup
    -- for more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- set icons to characters that are more likely to work in every terminal.
      --    feel free to remove or use ones that you like more! :)
      --    don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- install golang specific config
    require('dap-go').setup()
  end,
}
