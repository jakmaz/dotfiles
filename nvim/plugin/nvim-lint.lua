vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

local lint = require 'lint'
lint.linters_by_ft = {
  javascript = { 'biome' },
  typescript = { 'biome' },
  javascriptreact = { 'biome' },
  typescriptreact = { 'biome' },
  yml = { 'yamllint' },
  yaml = { 'yamllint' },
  sh = { 'shellcheck' },
  markdown = { 'rumdl' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.opt_local.modifiable:get() then
      lint.try_lint()
    end
  end,
})

vim.keymap.set('n', '<leader>l', function()
  lint.try_lint()
end, { desc = 'Trigger linting for current file' })
