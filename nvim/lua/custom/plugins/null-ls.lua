vim.cmd 'map <Leader>ln :NullLsInfo<CR>'
vim.cmd 'map <Leader>lf :lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>'

return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}
