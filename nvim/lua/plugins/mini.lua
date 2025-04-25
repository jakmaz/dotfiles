return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.bracketed').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup {
      mappings = {
        add = 'za', -- Add surrounding in Normal and Visual modes
        delete = 'zd', -- Delete surrounding
        find = 'zf', -- Find surrounding (to the right)
        find_left = 'zF', -- Find surrounding (to the left)
        highlight = 'zh', -- Highlight surrounding
        replace = 'zr', -- Replace surrounding
        update_n_lines = 'zn', -- Update `n_lines`
      },
    }
  end,
}
