vim.pack.add({ 'https://github.com/nvzone/volt' })
vim.pack.add({ 'https://github.com/aikhe/wrapped.nvim' })

require('wrapped').setup({})

vim.keymap.set('n', '<leader>ow', '<cmd>NvimWrapped<cr>', { desc = 'Wrap' })
