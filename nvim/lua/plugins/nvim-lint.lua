return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'biomejs' },
      typescript = { 'biomejs' },
      typescriptreact = { 'biomejs' },
      javascriptreact = { 'biomejs' },
      json = { 'biomejs' },
      css = { 'biomejs' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'shellcheck' },
      dockerfile = { 'hadolint' },
      markdown = { 'markdownlint-cli2' },
      yaml = { 'yamllint' },
      yml = { 'yamllint' },
    }

    -- Custom function to run actionlint only on GitHub Actions files
    local function lint_github_actions()
      local filepath = vim.api.nvim_buf_get_name(0)
      if filepath:match '%.github/workflows/.*%.ya?ml$' then lint.try_lint { 'actionlint' } end
    end

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        lint_github_actions()
      end,
    })

    vim.keymap.set('n', '<leader>cl', function() lint.try_lint() end, { desc = 'Trigger linting for current file' })
  end,
}
