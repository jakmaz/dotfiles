return {
  'saghen/blink.cmp',
  dependencies = { 'mikavilpas/blink-ripgrep.nvim', 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'enter' },

    appearance = {
      nerd_font_variant = 'normal',
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
      },
    },

    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      -- default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          opts = {},
        },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
