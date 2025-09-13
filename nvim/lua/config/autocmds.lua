-- Highlight on yank (your current autocommand)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Auto-reload files changed outside of Neovim
local autoread_group = vim.api.nvim_create_augroup('AutoRead', { clear = true })

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = autoread_group,
  desc = 'Auto check for file changes',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

-- Notification when file changes on disk
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = autoread_group,
  desc = 'Notify when file changed on disk',
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.INFO)
  end,
})

-- Open help pages as buffers instead of splits
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  desc = 'Open help pages in current buffer instead of split',
  callback = function()
    -- Make help buffer listed so it shows in buffer picker
    vim.bo.buflisted = true
    
    -- Only apply if help opened in a split (winnr > 1 means multiple windows)
    if vim.fn.winnr('$') > 1 then
      -- Move the help buffer to the main window
      local help_buf = vim.api.nvim_get_current_buf()
      vim.cmd('wincmd p') -- Go to previous window (main window)
      vim.api.nvim_set_current_buf(help_buf) -- Set help buffer in main window
      vim.cmd('helpclose') -- Close the help split
    end
  end,
})
