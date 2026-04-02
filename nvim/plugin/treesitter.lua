vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' } }

require('nvim-treesitter').setup {
  auto_install = true,
}
