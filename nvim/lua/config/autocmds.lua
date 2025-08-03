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
