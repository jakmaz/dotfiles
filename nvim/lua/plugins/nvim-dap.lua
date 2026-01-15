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
      -- Basic debugging keymaps
      { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Toggle Breakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
      {
        '<leader>dus',
        function()
          local widgets = require 'dap.ui.widgets'
          local sidebar = widgets.sidebar(widgets.scopes)
          sidebar.open()
        end,
        desc = 'Debug Sidebar',
      },

      -- Step-through debugging (essential for line-by-line debugging)
      { '<leader>ds', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },

      -- Session control
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
      { '<leader>dr', function() require('dap').restart() end, desc = 'Restart' },

      -- REPL and evaluation
      { '<leader>dR', function() require('dap').repl.open() end, desc = 'Open REPL' },
      { '<leader>dh', function() require('dap.ui.widgets').hover() end, desc = 'Hover Variables' },

      -- Advanced breakpoint management
      {
        '<leader>dB',
        function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
        desc = 'Conditional Breakpoint',
      },
      { '<leader>dC', function() require('dap').clear_breakpoints() end, desc = 'Clear Breakpoints' },
      {
        '<leader>dL',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ') end,
        desc = 'Log Point',
      },

      -- Quick debug sessions
      { '<leader>dd', function() require('dap').run_last() end, desc = 'Run Last' },
    },
    config = function()
      -- Clean, professional breakpoint symbols
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '►', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define(
        'DapBreakpointRejected',
        { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' }
      )
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = '◐', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' }
      )
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    end,
  },

  -- Go-specific DAP configuration
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'go',
    keys = {
      -- Go-specific debugging (organized under dg group)
      { '<leader>dgt', function() require('dap-go').debug_test() end, desc = 'Debug Test', ft = 'go' },
      { '<leader>dgl', function() require('dap-go').debug_last_test() end, desc = 'Debug Last Test', ft = 'go' },
      {
        '<leader>dgm',
        function()
          require('dap').continue { type = 'go', name = 'Debug', request = 'launch', program = '${workspaceFolder}' }
        end,
        desc = 'Debug Main',
        ft = 'go',
      },
      {
        '<leader>dgp',
        function()
          require('dap').continue {
            type = 'go',
            name = 'Debug Package',
            request = 'launch',
            program = './${relativeFileDirname}',
          }
        end,
        desc = 'Debug Package',
        ft = 'go',
      },
    },
    config = function()
      require('dap-go').setup() -- Works automatically with mason-nvim-dap
    end,
  },
}

