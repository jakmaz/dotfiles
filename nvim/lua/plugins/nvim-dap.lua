return {
  -- Mason-DAP bridge (handles Delve path automatically)
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    opts = {
      ensure_installed = { 'delve' },
      handlers = {}, -- Auto-setup with defaults
    },
  },

  -- Core DAP (Debug Adapter Protocol) plugin
  {
    'mfussenegger/nvim-dap',
    keys = {
      -- Basic debugging keymaps (matching tutorial exactly)
      { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Add breakpoint at line' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
      { '<leader>dus', function()
        local widgets = require('dap.ui.widgets')
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end, desc = 'Open debugging sidebar' },
    },
    config = function()
      -- Clean, professional breakpoint symbols
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '►', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◐', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    end,
  },

  -- Go-specific DAP configuration
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'go',
    keys = {
      -- Go-specific debugging (matching tutorial exactly)
      { '<leader>dgt', function() require('dap-go').debug_test() end, desc = 'Debug go test', ft = 'go' },
      { '<leader>dgl', function() require('dap-go').debug_last_test() end, desc = 'Debug last go test', ft = 'go' },
    },
    config = function()
      require('dap-go').setup() -- Works automatically with mason-nvim-dap
    end,
  },
}