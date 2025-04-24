return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.bracketed').setup()
    require('mini.pairs').setup()
    -- require('mini.surround').setup()
  end,
}
