vim.pack.add({ 'https://github.com/lewis6991/hover.nvim' })

require('hover').setup {
  init = function()
    -- Require providers
    require 'hover.providers.lsp'
    require 'hover.providers.gh'
    require 'hover.providers.gh_user'
    -- require('hover.providers.jira')
    -- require('hover.providers.dap')
    -- require('hover.providers.fold_preview')
    require 'hover.providers.diagnostic'
    -- require('hover.providers.man')
    require 'hover.providers.dictionary'
  end,
  preview_opts = {
    border = 'single',
  },
  title = true,
  mouse_providers = {
    'LSP',
  },
  mouse_delay = 1000,
}

vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
