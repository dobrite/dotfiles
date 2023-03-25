vim.cmd 'map <Leader>ln :NullLsInfo<CR>'
vim.cmd 'map <Leader>lf :lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>'

local M = {}
function M.installed_via_bundler(gemname)
  local gemfile_lock = vim.fn.getcwd() .. '/Gemfile.lock'

  if vim.fn.filereadable(gemfile_lock) == 0 then
    return
  end

  local found = false
  for line in io.lines(gemfile_lock) do
    if string.find(line, gemname) then
      found = true
      break
    end
  end

  return found
end

return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local sources = {
      null_ls.builtins.formatting.black, -- python
      null_ls.builtins.formatting.stylua, -- lua
      null_ls.builtins.formatting.prettierd, -- js/react
      null_ls.builtins.diagnostics.ruff, -- python
      null_ls.builtins.diagnostics.commitlint.with {
        extra_args = { '--config', os.getenv 'HOME' .. '/.commitlintrc.js' },
      },
      null_ls.builtins.code_actions.gitsigns,
    }

    if M.installed_via_bundler 'rubocop' then
      local rubocop_source = null_ls.builtins.diagnostics.rubocop.with {
        command = 'bundle',
        args = vim.list_extend({ 'exec', 'rubocop' }, null_ls.builtins.diagnostics.rubocop._opts.args),
      }

      vim.list_extend(sources, { rubocop_source })
    end
    null_ls.setup { sources = sources }
  end,
}
