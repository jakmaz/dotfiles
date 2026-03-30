vim.pack.add({ 'https://github.com/MagicDuck/grug-far.nvim' })

require('grug-far').setup({
  engine = 'ripgrep',
})

vim.keymap.set('n', '<leader>rf', function() require('grug-far').open() end, { desc = 'Replace in files (Grug-far)' })
vim.keymap.set('n', '<leader>rw', function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end, { desc = 'Replace word in files (Grug-far)' })
