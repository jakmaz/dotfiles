-- Make line numbers default
vim.opt.number = true

-- Use relative numbers
vim.opt.relativenumber = true

-- Remove tildes in the end of lines
vim.opt.fillchars = { eob = ' ' }

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Use bash as the default shell
vim.opt.shell = '/bin/bash'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

--- Better colors
vim.opt.termguicolors = true

-- Auto-reload files when changed externally
vim.opt.autoread = true

-- Tmux focus events support
vim.opt.title = true
vim.opt.titlestring = 'nvim - %{expand("%:t")}'

-- Tabs & Indentation
vim.opt.tabstop = 2 -- Number of visual spaces per TAB
vim.opt.softtabstop = 2 -- Number of spaces per TAB when editing
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Auto-indents new lines
vim.opt.autoindent = true -- Copy indent from current line when starting a new one

-- Disable line wrap
vim.opt.wrap = false

-- Disable native statusline (lualine will manage it)
vim.opt.laststatus = 0

-- Disable swapfile
vim.opt.swapfile = false
