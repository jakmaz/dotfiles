vim.pack.add({ 'https://github.com/williamboman/mason.nvim' }) -- 'mason-org/mason.nvim' redirects to williamboman
vim.pack.add({ 'https://github.com/williamboman/mason-lspconfig.nvim' })
vim.pack.add({ 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' })
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'pyright',
    'eslint',
    'rust_analyzer',
    'clangd',
    'tsgo',
    'harper_ls',
    'java_language_server',
    'tinymist',
    'biome',
    'jsonls',
    'yamlls',
    'taplo',
    'bashls',
    'gopls',
    'docker_language_server',
    'terraformls',
  },
  automatic_enable = {
    exclude = {
      'harper_ls',
    },
  },
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'tflint',
    'trivy',
    'shellcheck',
    'hadolint',
    'rumdl',
    'yamllint',
    'actionlint',
    'biome',
    'stylua',
    'terraform',
    'beautysh',
    'typstyle',
    'mbake',
    'delve',
    'goimports',
    'sqruff',
    'just-lsp',
  },
  auto_update = false,
  run_on_start = true,
})

-- The user configuration sets lsp.config which is part of nvim-lspconfig setup natively
vim.lsp.config('harper_ls', {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown' },
  root_markers = { '.git' },
})

vim.lsp.config('nushell', {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
})
