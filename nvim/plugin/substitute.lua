vim.pack.add { 'https://github.com/gbprod/substitute.nvim' }

require('substitute').setup {
  highlight_substituted_text = {
    timer = 100,
  },
}
vim.keymap.set('n', 's', require('substitute').operator, { noremap = true, desc = 'Substitute' })
vim.keymap.set('n', 'ss', require('substitute').line, { noremap = true, desc = 'Substitute line' })
vim.keymap.set('n', 's', require('substitute').operator, { noremap = true, desc = 'Substitute' })
vim.keymap.set('x', 's', require('substitute').visual, { noremap = true, desc = 'Substitute selection' })

vim.keymap.set('n', '<leader>rx', require('substitute.exchange').operator, { noremap = true, desc = 'Exchange' })
vim.keymap.set('n', '<leader>rxx', require('substitute.exchange').line, { noremap = true, desc = 'Exchange line' })
vim.keymap.set(
  'x',
  '<leader>rX',
  require('substitute.exchange').visual,
  { noremap = true, desc = 'Exchange selection' }
)
vim.keymap.set('n', '<leader>rxc', require('substitute.exchange').cancel, { noremap = true, desc = 'Cancel exchange' })
