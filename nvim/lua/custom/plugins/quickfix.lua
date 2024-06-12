local function set_quickfix_height()
  vim.cmd 'wincmd J'
  vim.cmd 'resize 20'
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = set_quickfix_height,
})

return {}
