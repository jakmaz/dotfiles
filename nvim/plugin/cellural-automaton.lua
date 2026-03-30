vim.pack.add({ 'https://github.com/eandrju/cellular-automaton.nvim' })

vim.keymap.set('n', '<leader>ur', '<Cmd>CellularAutomaton make_it_rain<CR>', { desc = 'Make it rain' })