vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })
vim.pack.add({ 'https://github.com/Bilal2453/luvit-meta' })

require('lazydev').setup({
  library = {
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  },
})
