vim.pack.add({ 'https://github.com/meznaric/key-analyzer.nvim' })

require('key-analyzer').setup()

vim.keymap.set('n', '<leader>oka', '<cmd>KeyAnalyzer<cr>', { desc = 'Key Analyzer' })
