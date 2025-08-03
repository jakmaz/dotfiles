-- Diagnostic configuration
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = {
    current_line = true,
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',  -- Error icon
      [vim.diagnostic.severity.WARN] = '󰀪',   -- Warning icon
      [vim.diagnostic.severity.INFO] = '󰋽',   -- Info icon
      [vim.diagnostic.severity.HINT] = '󰌶',   -- Hint icon
    },
  },
}
