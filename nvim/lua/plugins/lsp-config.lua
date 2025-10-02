return {
  -- Mason: installs and manages external tools like LSP servers
  {
    'mason-org/mason.nvim',
    opts = {},
  },

  -- Mason-LSPConfig: tells Mason which servers to install and links them to lspconfig
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls', -- Lua (great for editing Neovim config)
        'pyright', -- Python
        'eslint', -- Nextjs Linting
        'rust_analyzer', -- Rust
        'clangd', -- C / C++
        'tailwindcss', -- Tailwind CSS
        'harper_ls', -- Spell check
        'java_language_server', -- Java
        'tinymist', -- Typst
        'biome', -- Lint, format for json, yaml, markdown, etc.
        'jsonls', -- JSON (standalone)
        'yamlls', -- YAML
        'taplo', -- TOML
        'bashls', -- Bash/shell scripting
        'gopls', -- Go
      },
      automatic_enable = {
        exclude = {
          'harper_ls',
        },
      },
    },
  },

  -- nvim-lspconfig: connects Neovim to installed LSP servers
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('harper_ls', {
        cmd = { 'harper-ls', '--stdio' },
        filetypes = { 'markdown' },
        root_markers = { '.git' },
      })
    end,
  },
}
