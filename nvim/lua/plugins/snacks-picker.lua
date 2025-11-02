return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            -- Remap conflicting tmux keybinds
            ["<C-w>w"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-r>r"] = { "toggle_regex", mode = { "i", "n" } },
            ["<C-p>"] = { "toggle_preview", mode = { "i", "n" } },
            -- Disable the conflicting ones
            ["<a-w>"] = nil,
            ["<a-r>"] = nil,
            ["<a-p>"] = nil,
          }
        }
      },
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            { preview = true },
            layout = {
              box = 'horizontal',
              width = 0.8,
              height = 0.8,
              {
                box = 'vertical',
                border = 'rounded',
                title = '{source} {live} {flags}',
                title_pos = 'center',
                { win = 'input', height = 1, border = 'bottom' },
                { win = 'list', border = 'none' },
              },
              { win = 'preview', border = 'rounded', width = 0.6, title = '{preview}' },
            },
          },
          win = {
            list = {
              keys = { ['<Right>'] = 'confirm', ['<Left>'] = 'explorer_close' },
              wo = {
                number = true,
                relativenumber = true,
              },
            },
          },
        },
      },
    },
  },
}
