return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      sources = {
        explorer = {
          layout = {
            { preview = true },
            layout = {
              box = 'horizontal',
              width = 0.8,
              height = 0.8,
              {
                box = 'vertical',
                border = 'rounded',
                title = '{source} {live} {flags}',
                title_pos = 'center',
                { win = 'input', height = 1, border = 'bottom' },
                { win = 'list', border = 'none' },
              },
              { win = 'preview', border = 'rounded', width = 0.7, title = '{preview}' },
            },
          },
          win = {
            list = {
              keys = { ['<Right>'] = 'confirm', ['<Left>'] = 'explorer_close' },
              wo = {
                number = true, -- Enable line numbers
                relativenumber = true, -- Enable relative line numbers
              },
            },
          },
        },
      },
    },
  },
}

