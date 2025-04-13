return {
  -- Mason: installs and manages external tools like LSP servers
  {
    'williamboman/mason.nvim',
    opts = {},
  },

  -- Mason-LSPConfig: tells Mason which servers to install and links them to lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls',               -- Lua (great for editing Neovim config)
        'pyright',              -- Python
        'ts_ls',                -- TypeScript / JavaScript
        'rust_analyzer',        -- Rust
        'clangd',               -- C / C++
        'tailwindcss',          -- Tailwind CSS
        'marksman',             -- Markdown
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
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Python
      lspconfig.pyright.setup {}

      -- JavaScript / TypeScript
      lspconfig.ts_ls.setup {}

      -- Rust
      lspconfig.rust_analyzer.setup {}

      -- C / C++
      lspconfig.clangd.setup {}

      -- Tailwind CSS
      lspconfig.tailwindcss.setup {}

      -- Markdown
      lspconfig.marksman.setup {}

      -- Java
      lspconfig.java_language_server.setup {}
    end,
  },
}
