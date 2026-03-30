vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ 'https://github.com/alanfortlink/blackjack.nvim' })

vim.keymap.set('n', '<leader>ob', '<cmd>BlackJackNewGame<cr>', { desc = 'Blackjack' })