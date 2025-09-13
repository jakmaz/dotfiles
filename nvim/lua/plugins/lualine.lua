return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { statusline = { 'snacks_dashboard' } },
    },

    sections = {
      lualine_a = {},
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = {
        {
          function()
            local toggle = Snacks.toggle.get 'supermaven'
            if toggle and toggle:get() then
              return ''
            else
              return ''
            end
          end,
          color = function()
            local toggle = Snacks.toggle.get 'supermaven'
            if toggle and toggle:get() then
              return { fg = '#ffffff' }
            else
              return { fg = '#6272a4' }
            end
          end,
        },
        'filetype',
      },
      lualine_y = { 'location' },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { 'lazy', 'mason', 'neo-tree' },
  },
}
