return {
  dir = '/Users/jakubmazur/git/oxide/nvim',
  name = 'oxide.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function() vim.cmd.colorscheme 'oxide' end,
}
