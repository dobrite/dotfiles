vim.o.mouse = ""

-- whitespace
vim.o.list = true -- show whitespace
vim.o.listchars = 'tab:>-,trail:#,precedes:<,extends:>' -- formatting for shown whitespace
-- end whitespace

-- line numbers
vim.o.number = true
vim.o.numberwidth = 1
-- end line numbers

-- line wrapping
vim.o.wrap = false -- turn off line wrapping
vim.o.linebreak = true -- don't wrap text in the middle of a word
-- end line wrapping

-- searching and patterns
vim.o.ignorecase = true -- Default to using case insensitive searches,
vim.o.smartcase = true -- unless uppercase letters are used in the regex.
vim.o.hlsearch = true -- Highlight searches by default.
vim.o.incsearch = true -- Incrementally search while typing a /regex
-- hide matches on <leader>,
vim.api.nvim_set_keymap("n", "<leader>,", ":nohlsearch<CR>", { noremap = true })
-- end searching and patterns

local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
	map('n', shortcut, command)
end

local function imap(shortcut, command)
	map('i', shortcut, command)
end

-- navigation ctrl-jklm changes to that split
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('<c-l>', '<c-w>l')
nmap('<c-h>', '<c-w>h')
imap('<C-w>', '<C-O><C-w>') -- not sure what this does
-- end navigation

-- close buffer and don't close split
nmap('<leader>w', ':b#<bar>bd#<CR>')

return {}
