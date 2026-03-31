vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' } }

require('nvim-treesitter').setup {
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'tsx',
  },
  auto_install = true,
}
