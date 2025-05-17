return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy', -- Ensures keys work by using 'VeryLazy'

  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<S-Left>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-Right>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { 'M', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer (Alt)' },
    { 'I', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer (Alt)' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move Buffer Prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move Buffer Next' },
  },

  dependencies = 'nvim-tree/nvim-web-devicons',

  opts = {
    options = {
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, _, _)
        local icon = level:match 'error' and ' ' or ' '
        return ' ' .. icon .. count
      end,
      offsets = {
        { filetype = 'snacks_layout_box' },
      },
      always_show_bufferline = false,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
    },
  },
}

