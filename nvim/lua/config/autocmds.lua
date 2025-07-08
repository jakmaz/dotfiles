-- Highlight on yank (your current autocommand)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  desc = 'Auto check for file changes on focus or buffer enter',
  callback = function() vim.cmd 'checktime' end,
})
