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
        'docker_language_server', -- Docker
        'terraformls', -- Terraform language server
      },
      automatic_enable = {
        exclude = {
          'harper_ls',
        },
      },
    },
  },

  -- Mason-Tool-Installer: automatically installs all tools (linters, formatters, etc.)
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Linters
        'tflint', -- Terraform linter
        'trivy', -- Security scanner
        'shellcheck', -- Shell script linter
        'hadolint', -- Dockerfile linter
        'markdownlint-cli2', -- Markdown linter
        'yamllint', -- YAML linter
        'actionlint', -- GitHub Actions linter
        'biome', -- JS/TS/JSON linter

        -- Formatters
        'stylua', -- Lua formatter
        'terraform', -- Terraform CLI (includes terraform fmt)
        'beautysh', -- Shell script formatter
        'typstyle', -- Typst formatter

        -- Other tools
        'mbake', -- Makefile formatter and litner
        'delve', -- Go debugger
      },
      auto_update = false, -- Set to true if you want automatic updates
      run_on_start = true, -- Install missing tools when Neovim starts
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
