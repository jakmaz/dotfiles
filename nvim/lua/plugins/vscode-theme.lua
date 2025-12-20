return {
  'Mofiqul/vscode.nvim',
  config = function()
    require('vscode').setup {
      theme = 'dark_plus',
      transparent = false,
      italic_comments = true,
      contrast = 'high',
      disable_float = false,
      disable_italic = false,
      disable_color_preview = false,
      disable_sidebars = false,
      sidebars = {},
      float = {},
      colors = {},
      highlights = {},
      styles = {},
      filetypes = {},
    }
  end,
}
