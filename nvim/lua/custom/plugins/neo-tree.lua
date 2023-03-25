vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

local function opts(prefix, desc)
  return {
    desc = prefix .. ': ' .. desc,
  }
end

vim.keymap.set('n', '<c-n>', '<cmd>Neotree toggle<cr>', opts('NEO-TREE', 'open neotree'))

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v2.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree').close_all()
          end,
        },
      },
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    }
  end,
}
