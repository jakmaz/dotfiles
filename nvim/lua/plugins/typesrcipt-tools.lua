local filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

return {
  'pmizio/typescript-tools.nvim',
  ft = filetypes,
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    filetypes = filetypes,
  },
  config = function(_, opts)
    require('typescript-tools').setup(opts)
    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWritePre', {
      pattern = '*.ts,*.tsx,*.jsx,*.js',
      callback = function() vim.cmd 'TSToolsOrganizeImports sync' end,
    })
  end,
  keys = {
    { '<leader>cO', '<Cmd>TSToolsOrganizeImports<CR>', desc = 'Organize Imports' },
    { '<leader>cm', '<Cmd>TSToolsAddMissingImports<CR>', desc = 'Add missing imports' },
    { '<leader>cu', '<Cmd>TSToolsRemoveUnusedImports<CR>', desc = 'Remove unused imports' },
    { '<leader>cD', '<Cmd>TSToolsFixAll<CR>', desc = 'Fix all diagnostics' },
  },
}
