return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'helix',
    delay = 500,
    icons = {
      mappings = false,
      group = '',
    },

    -- Document existing key chains
    spec = {
      { '<leader>c', group = 'Code', mode = { 'n', 'x' } },
      { '<leader>d', group = 'Document' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>f', group = 'Find' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>gh', group = 'Git Hunk', mode = { 'n', 'v' } },
      { '<leader>g', group = 'Git' },
      { '<leader>o', group = 'Other' },
      { '<leader>u', group = 'Ui' },
      { '<leader>b', group = 'Buffers' },
      { '<leader>l', group = 'Logs' },
    },
  },
}
