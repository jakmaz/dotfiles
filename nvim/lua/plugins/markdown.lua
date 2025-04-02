return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = { enabled = false },
  keys = {
    {
      '<leader>or',
      '<cmd>:RenderMarkdown toggle<cr>',
      desc = 'Render Markdown Toggle',
    },
  },
  ft = 'markdown',
}
