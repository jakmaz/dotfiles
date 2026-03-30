vim.pack.add({ 'https://github.com/hedyhli/outline.nvim' })

require('outline').setup({
  outline_window = {
    position = 'right',
    split_command = nil,
    width = 25,
    auto_close = false,
    auto_jump = false,
    jump_highlight_duration = 300,
    center_on_jump = true,
  },
  outline_items = {
    show_symbol_details = true,
    show_symbol_lineno = false,
    highlight_hovered_item = true,
    show_guides = true,
  },
  guides = {
    icons = {
      hover = '┃',
      hl = '┃',
    },
  },
  symbol_folding = {
    autofold_depth = 1,
    auto_unfold_hover = true,
    markers = { '', '' },
  },
})

vim.keymap.set('n', '<leader>oO', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
