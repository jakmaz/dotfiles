return {
  'nyoom-engineering/oxocarbon.nvim',
  commit = '8f22819',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function() vim.cmd.colorscheme 'oxocarbon' end,
}
