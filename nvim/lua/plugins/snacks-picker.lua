return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      sources = {
        explorer = {
          layout = { auto_hide = { 'input' } },
          win = { list = { keys = { ['<Right>'] = 'confirm', ['<Left>'] = 'explorer_close' } } },
        },
      },
    },
  },
}
