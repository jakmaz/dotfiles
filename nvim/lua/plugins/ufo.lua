return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',
  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', '+', 'zo', { desc = 'Open fold under cursor' })
    vim.keymap.set('n', '-', 'zc', { desc = 'Close fold under cursor' })

    require('ufo').setup {
      provider_selector = function(_, _, _) return { 'lsp', 'indent' } end,
    }
  end,
}
