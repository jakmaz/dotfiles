vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  preset = 'helix',
  delay = 500,
  icons = {
    mappings = false,
    group = '',
  },
  spec = {
    { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
    { '<leader>cg', group = 'Go Code' },
    { '<leader>cgt', group = 'Go Tags' },
    { '<leader>cgi', group = 'Go Generate' },
    { '<leader>cgm', group = 'Go Mod' },
    { '<leader>d', group = 'Debug' },
    { '<leader>dg', group = 'Debug Go' },
    { '<leader>du', group = 'Debug Ui' },
    { '<leader>g', group = 'Git' },
    { '<leader>gh', group = 'Git Hunk', mode = { 'n', 'v' } },
    { '<leader>n', group = 'Next' },
    { '<leader>p', group = 'Previous' },
    { '<leader>r', group = 'Replace' },
    { '<leader>s', group = 'Search' },
    { '<leader>w', group = 'Workspace' },
    { '<leader>f', group = 'Find' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>o', group = 'Other' },
    { '<leader>u', group = 'Ui' },
    { '<leader>b', group = 'Buffers' },
    { '<leader>l', group = 'Logs' },
  },
})
