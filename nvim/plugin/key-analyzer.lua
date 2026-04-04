vim.pack.add { 'https://github.com/meznaric/key-analyzer.nvim' }

require('key-analyzer').setup { layout = 'colemak_dh' }

vim.keymap.set('n', '<leader>ok', '<cmd>KeyAnalyzer leader<cr>', { desc = 'Key Analyzer' })
