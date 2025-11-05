return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      -- Use the modern preset for clean appearance
      preset = 'classic',

      options = {
        -- Display the source of diagnostics (e.g., "lua_ls", "pyright")
        show_source = {
          enabled = true, -- Enable showing source names
          if_many = false, -- Only show source if multiple sources exist for the same diagnostic
        },
      },
    }
    -- Disable Neovim's default virtual text diagnostics to prevent conflicts
    vim.diagnostic.config { virtual_text = false }
  end,
}
