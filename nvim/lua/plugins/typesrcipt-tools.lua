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
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'all',
        includeCompletionsForModuleExports = true,
        quotePreference = 'auto',
        autoImportFileExcludePatterns = { '**/node_modules/@radix-ui/**' },
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
    },
  },
  config = function(_, opts) require('typescript-tools').setup(opts) end,
  keys = {
    { '<leader>cO', '<Cmd>TSToolsOrganizeImports<CR>', desc = 'Organize Imports' },
    { '<leader>cm', '<Cmd>TSToolsAddMissingImports<CR>', desc = 'Add missing imports' },
    { '<leader>cu', '<Cmd>TSToolsRemoveUnusedImports<CR>', desc = 'Remove unused imports' },
    { '<leader>cD', '<Cmd>TSToolsFixAll<CR>', desc = 'Fix all diagnostics' },
  },
}
