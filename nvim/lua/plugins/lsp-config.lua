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
        'ts_ls', -- TypeScript / JavaScript
        'eslint', -- Nextjs Linting
        'rust_analyzer', -- Rust
        'clangd', -- C / C++
        'tailwindcss', -- Tailwind CSS
        'harper_ls', -- Spell check
        'java_language_server', -- Java
      },
    },
  },

  -- nvim-lspconfig: connects Neovim to installed LSP servers
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Lua (for Neovim configuration)
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }
      lspconfig.pyright.setup {}
      lspconfig.ts_ls.setup {}
      -- lspconfig.eslint.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.clangd.setup {}
      lspconfig.tailwindcss.setup {}
      lspconfig.harper_ls.setup { filetypes = { 'markdown' } }
      lspconfig.java_language_server.setup {}
    end,
  },
}
