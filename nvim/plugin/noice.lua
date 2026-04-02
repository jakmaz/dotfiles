vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }
vim.pack.add { 'https://github.com/folke/noice.nvim' }

require('noice').setup {
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  cmdline = {
    view = 'cmdline', -- Bottom cmdline only
    format = {
      lua = false, -- Disable lua mode icon/padding completely
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
    long_message_to_split = false,
    inc_rename = false,
    lsp_doc_border = false,
  },
}
