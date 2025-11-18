return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      return {
        timeout_ms = 2500,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'biome-check' },
      typescript = { 'biome-check' },
      javascriptreact = { 'biome-check' },
      typescriptreact = { 'biome-check' },
      markdown = { 'markdownlint-cli2' },
      json = { 'biome-check' },
      css = { 'biome-check' },
      typst = { 'typstyle' },
      sh = { 'beautysh' },
      go = { 'gofumpt', 'goimports' },
    },
  },
}
