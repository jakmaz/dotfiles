return {
  'lewis6991/hover.nvim',
  config = function()
    require('hover').config {
      providers = {
        'hover.providers.diagnostic',
        'hover.providers.lsp',
        'hover.providers.dap',
        'hover.providers.man',
        'hover.providers.gh',
        'hover.providers.gh_user',
        'hover.providers.fold_preview',
        'hover.providers.highlight',
      },
      preview_opts = {
        border = 'rounded',
      },
      preview_window = false,
      title = true,
    }

    vim.keymap.set('n', 'K', function() require('hover').open() end, { desc = 'hover.nvim (open)' })

    vim.keymap.set('n', 'gK', function() require('hover').enter() end, { desc = 'hover.nvim (enter)' })

    vim.keymap.set(
      'n',
      '<M-p>',
      function() require('hover').switch 'previous' end,
      { desc = 'hover.nvim (previous source)' }
    )

    vim.keymap.set('n', '<M-n>', function() require('hover').switch 'next' end, { desc = 'hover.nvim (next source)' })
  end,
}
