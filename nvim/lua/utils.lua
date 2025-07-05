local M = {}
M.initial_cwd = vim.fn.getcwd()

function M.installed_via_bundler(gemname)
  local gemfile = M.gemfile()
  if not gemfile then
    return false
  end

  local found = false
  for line in io.lines(gemfile) do
    if string.find(line, gemname) then
      found = true
      break
    end
  end

  return found
end

function M.gemfile()
  local gemfile = vim.fn.getcwd() .. '/Gemfile.lock'

  if vim.fn.filereadable(gemfile) == 0 then
    return nil
  end

  return gemfile
end

function M.installed_gem_version(gemname)
  -- TODO: support version number for non-bundler gems, default bundler = true param

  local gemfile = M.gemfile()
  if not gemfile then
    return nil
  end

  local version = nil

  for line in io.lines(gemfile) do
    if string.find(line, '%s+' .. gemname .. ' %(') then
      version = string.match(line, '%((.-)%)')
      break
    end
  end

  return version
end

function M.rubocop_supports_lsp()
  local version = M.installed_gem_version 'rubocop'

  -- rubocop lsp was added in v1.53.0
  return version and vim.version.ge(version, { 1, 53, 0 })
end

function M.rubocop_version_doesnt_hose_everything()
  local version = M.installed_gem_version 'rubocop'

  -- https://github.com/rubocop/rubocop/issues/13561
  return version and vim.version.ge(version, { 1, 69, 0 })
end

function M.is_product(name)
  -- method to grab the last folder off the cwd
  local cwd = vim.fn.getcwd()
  local product = cwd:match '([^/]+)/?$'

  return product == name
end

function M.ruby_lsp_setup()
  local directory = vim.fn.getcwd() .. '/.ruby-lsp'

  return M.is_dir(directory)
end

function M.config_exists(filename)
  local file = vim.fn.getcwd() .. '/' .. filename

  return vim.fn.filereadable(file) == 1
end

function M.is_dir(filename)
  return M.exists(filename) == 'directory'
end

function M.is_file(filename)
  return M.exists(filename) == 'file'
end

function M.exists(filename)
  local stat = (vim.uv or vim.loop).fs_stat(filename)
  return stat and stat.type or false
end

function M.toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd 'cclose'
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd 'copen'
  else
    vim.notify('quickfix list is empty', vim.log.levels.WARN)
  end
end

function M.toggle_loclist()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win['loclist'] == 1 then
      vim.cmd 'lclose'
      return
    end
  end

  if next(vim.fn.getloclist(0)) == nil then
    vim.notify('location list empty', vim.log.levels.WARN)
    return
  end
  vim.cmd 'lopen'
end

function M.open_init_lua()
  local config_path = vim.fn.stdpath 'config'
  local init_lua = config_path .. '/init.lua'

  vim.cmd('edit ' .. init_lua)
  vim.cmd('cd ' .. config_path)
  vim.notify('Opened init.lua and set cwd to ' .. config_path, vim.log.levels.INFO)
end

function M.restore_previous_cwd()
  local current_dir = vim.fn.getcwd()

  if current_dir ~= M.initial_cwd then
    vim.cmd('cd ' .. M.initial_cwd)
    vim.notify('Restored to initial working directory: ' .. M.initial_cwd, vim.log.levels.INFO)
  else
    vim.notify('Already in the initial working directory', vim.log.levels.INFO)
  end
end

function M.reload_config()
  -- Clear module cache to ensure fresh modules are loaded
  local function clear_cache()
    for module_name, _ in pairs(package.loaded) do
      if module_name:match '^user' or module_name:match '^plugins' or module_name:match '^lua' or module_name == 'utils' then
        package.loaded[module_name] = nil
      end
    end
  end

  -- Save cursor position
  local cursor_pos = vim.fn.getcurpos()

  -- Reload init.lua and clear cache
  clear_cache()
  vim.cmd('source ' .. vim.fn.stdpath 'config' .. '/init.lua')

  -- Reload Lazy plugins if available
  local lazy_ok, lazy = pcall(require, 'lazy')
  if lazy_ok then
    -- Sync plugins to load any changes
    lazy.sync { show = false }
  end

  -- Restore cursor position
  vim.fn.setpos('.', cursor_pos)
  vim.notify('Neovim configuration reloaded!', vim.log.levels.INFO)
end

return M
