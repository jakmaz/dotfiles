vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' })
vim.pack.add({ 'https://github.com/L3MON4D3/LuaSnip' })
vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') } })

require('blink.cmp').setup({
  keymap = { preset = 'super-tab' },
  appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
  completion = {
    keyword = { range = 'full' },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
      },
      border = 'none',
    },
    documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'none' } },
  },
  signature = { enabled = true, window = { border = 'none' } },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
})
