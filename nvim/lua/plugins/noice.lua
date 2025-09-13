return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      -- Remove command_palette if you want normal commands at the bottom
      command_palette = false,
    },
    -- Optional: you can keep bottom_search and style messages without overriding commands
    cmdline = {
      format = {
        cmdline = { view = 'cmdline' }, -- normal commands at bottom
        search_down = { view = 'cmdline' }, -- normal search at bottom
        search_up = { view = 'cmdline' },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
