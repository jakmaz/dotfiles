return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  keys = {
    { '<leader>tp', '<cmd>TypstPreview<cr>', desc = 'Typst Preview' },
    { '<leader>tP', '<cmd>TypstPreviewStop<cr>', desc = 'Typst Preview Stop' },
  },
  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
}
