vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require('todo-comments').setup({ signs = false })
