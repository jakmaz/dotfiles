vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    json = { 'biome' },
    go = { 'goimports', 'gofmt' },
    javascript = { 'biome' },
    typescript = { 'biome' },
    javascriptreact = { 'biome' },
    typescriptreact = { 'biome' },
    python = { 'black' },
    rust = { 'rustfmt' },
    yaml = { 'biome' },
  },
}
