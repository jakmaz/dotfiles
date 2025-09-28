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
    vim.keymap.set('n', '<leader>r', require('substitute').operator, { noremap = true, desc = 'Replace with motion' })
    vim.keymap.set('n', '<leader>rr', require('substitute').line, { noremap = true, desc = 'Replace line' })
    vim.keymap.set('n', '<leader>R', require('substitute').eol, { noremap = true, desc = 'Replace to end of line' })
    vim.keymap.set('x', '<leader>r', require('substitute').visual, { noremap = true, desc = 'Replace selection' })

    -- Substitute over range motion
    vim.keymap.set(
      'n',
      '<leader>rs',
      require('substitute.range').operator,
      { noremap = true, desc = 'Replace in range' }
    )
    vim.keymap.set('x', '<leader>rs', require('substitute.range').visual, { noremap = true, desc = 'Replace in range' })
    vim.keymap.set(
      'n',
      '<leader>rw',
      require('substitute.range').word,
      { noremap = true, desc = 'Replace word in range' }
    )

    -- Exchange operator
    vim.keymap.set(
      'n',
      '<leader>rx',
      require('substitute.exchange').operator,
      { noremap = true, desc = 'Exchange with motion' }
    )
    vim.keymap.set('n', '<leader>rxx', require('substitute.exchange').line, { noremap = true, desc = 'Exchange line' })
    vim.keymap.set(
      'x',
      '<leader>rX',
      require('substitute.exchange').visual,
      { noremap = true, desc = 'Exchange selection' }
    )
    vim.keymap.set(
      'n',
      '<leader>rxc',
      require('substitute.exchange').cancel,
      { noremap = true, desc = 'Cancel exchange' }
    )
  end,
}
