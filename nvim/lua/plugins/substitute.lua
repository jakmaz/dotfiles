return {
  'gbprod/substitute.nvim',
  config = function()
    require('substitute').setup {
      on_substitute = nil,
      yank_substituted_text = false,
      preserve_cursor_position = false,
      highlight_substituted_text = {
        enabled = true,
        timer = 100,
      },
    }

    -- Substitute operator
    vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
    vim.keymap.set('n', 'gss', require('substitute').line, { noremap = true })
    vim.keymap.set('n', 'gS', require('substitute').eol, { noremap = true })
    vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
  end,
}
