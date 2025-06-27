local M = {}

local function do_open(uri)
  local cmd, err = vim.ui.open(uri)
  local rv = cmd and cmd:wait(1000) or nil
  if cmd and rv and rv.code ~= 0 then
    err = ('vim.ui.open: command %s (%d): %s'):format((rv.code == 124 and 'timeout' or 'failed'), rv.code, vim.inspect(cmd.cmd))
  end

  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

function M.open_commit_url()
  local cwd = vim.fn.getcwd()

  local function is_sha()
    local word = vim.fn.expand '<cword>'
    return word:match '^[0-9a-fA-F]+$'
  end

  local function get_github_repo_url()
    local handle = io.popen('git -C ' .. cwd .. ' remote get-url origin')
    if not handle then
      return nil
    end

    local result = handle:read '*a'
    local success = handle:close()
    if not success then
      return nil
    end

    if result and result ~= '' then
      result = result:gsub('%s+$', '')
      local repo_path = result:match 'github.com[:/](.+)%.git'
      return repo_path
    end

    return nil
  end

  local repo_path = get_github_repo_url()

  if repo_path and is_sha() then
    local sha = vim.fn.expand '<cword>'
    local url = 'https://github.com/' .. repo_path .. '/commit/' .. sha
    vim.ui.open(url)
  else
    do_open(vim.fn.expand '<cfile>')
  end
end

vim.api.nvim_create_user_command('OpenCommitOrDefaultOpen', M.open_commit_url, {})
vim.keymap.set('n', 'gx', ':OpenCommitOrDefaultOpen<CR>', { desc = 'Open commit or default open' })

return {}
