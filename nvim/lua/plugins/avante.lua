return {
  'yetone/avante.nvim',
  build = 'make',
  event = 'VeryLazy',
  version = false,
  opts = {
    provider = 'copilot',
    hints = {
      enabled = false,
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
}
