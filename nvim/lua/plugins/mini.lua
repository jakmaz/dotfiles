return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
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
    require('mini.move').setup {
      mappings = {
        -- Move visual selection in Visual mode using Alt + Arrow keys
        left = '<M-Left>',
        right = '<M-Right>',
        down = '<M-Down>',
        up = '<M-Up>',

        -- Move current line in Normal mode using Alt + Arrow keys
        line_left = '<M-Left>',
        line_right = '<M-Right>',
        line_down = '<M-Down>',
        line_up = '<M-Up>',
      },
    }
  end,
}
