vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
vim.pack.add { { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '*' } }

require('blink.cmp').setup {
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  keymap = { preset = 'enter' },
  appearance = { nerd_font_variant = 'normal' },
  completion = {
    keyword = { range = 'full' },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      -- border = 'rounded', -- Adds border to the autocomplete menu
      draw = { treesitter = { 'lsp' } },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      -- window = { border = 'rounded' }, -- Changed from 'none' to 'rounded'
    },
  },
  signature = {
    enabled = true,
    -- window = { border = 'rounded' }, -- Adds border to the signature help
  },
}
