vim.cmd 'map <Leader>ln :NullLsInfo<CR>'
vim.cmd 'map <Leader>li :LspInfo<CR>'
vim.cmd 'map <Leader>lf :lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>'
vim.cmd 'map <Leader>lr :LspRestart<CR>'

local utils = require 'utils'
-- vim.lsp.set_log_level 'debug'

return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local sources = {
      null_ls.builtins.diagnostics.eslint_d, -- js
      null_ls.builtins.diagnostics.ruff, -- python
      null_ls.builtins.diagnostics.commitlint.with {
        extra_args = { '--config', os.getenv 'HOME' .. '/.commitlintrc.js' },
      },
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.eslint_d, -- js
    }

    if utils.installed_via_bundler 'rubocop' then
      local rubocop_source = null_ls.builtins.diagnostics.rubocop.with {
        command = 'bundle',
        args = vim.list_extend({ 'exec', 'rubocop' }, null_ls.builtins.diagnostics.rubocop._opts.args),
      }

      vim.list_extend(sources, { rubocop_source })
    end
    null_ls.setup { sources = sources }
  end,
}
