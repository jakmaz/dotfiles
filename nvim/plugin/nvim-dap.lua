vim.pack.add { 'https://github.com/mfussenegger/nvim-dap' }
vim.pack.add { 'https://github.com/igorlfs/nvim-dap-view' }
vim.pack.add { 'https://github.com/leoluz/nvim-dap-go' }

-- Customize DAP signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define(
  'DapBreakpointCondition',
  { text = '◐', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' }
)
vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '►', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

-- Basic debugging keymaps
vim.keymap.set('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue' })

-- DAP UI keymaps
vim.keymap.set('n', '<leader>du', '<cmd>DapViewToggle<CR>', { desc = 'Toggle Debug UI' })
vim.keymap.set('n', '<leader>dw', '<cmd>DapViewWatch<CR>', { desc = 'Add Watch Expression' })
vim.keymap.set('v', '<leader>dw', '<cmd>DapViewWatch<CR>', { desc = 'Add Watch Expression' })

-- Jump to specific DAP views
vim.keymap.set('n', '<leader>dvw', '<cmd>DapViewJump watches<CR>', { desc = 'Jump to Watches' })
vim.keymap.set('n', '<leader>dvt', '<cmd>DapViewJump threads<CR>', { desc = 'Jump to Threads' })
vim.keymap.set('n', '<leader>dvb', '<cmd>DapViewJump breakpoints<CR>', { desc = 'Jump to Breakpoints' })
vim.keymap.set('n', '<leader>dvs', '<cmd>DapViewJump scopes<CR>', { desc = 'Jump to Scopes' })
vim.keymap.set('n', '<leader>dvr', '<cmd>DapViewJump repl<CR>', { desc = 'Jump to REPL' })

-- Step-through debugging
vim.keymap.set('n', '<leader>ds', function() require('dap').step_over() end, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'Step Out' })

-- Session control
vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>dr', function() require('dap').restart() end, { desc = 'Restart' })

-- REPL and evaluation
vim.keymap.set('n', '<leader>dR', function() require('dap').repl.open() end, { desc = 'Open REPL' })
vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Hover Variables' })

-- Advanced breakpoint management
vim.keymap.set(
  'n',
  '<leader>dB',
  function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
  { desc = 'Conditional Breakpoint' }
)
vim.keymap.set('n', '<leader>dC', function() require('dap').clear_breakpoints() end, { desc = 'Clear Breakpoints' })
vim.keymap.set(
  'n',
  '<leader>dL',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ') end,
  { desc = 'Log Point' }
)

-- Quick debug sessions
vim.keymap.set('n', '<leader>dd', function() require('dap').run_last() end, { desc = 'Run Last' })

-- Go-specific debugging (organized under dg group)
vim.keymap.set('n', '<leader>dgt', function() require('dap-go').debug_test() end, { desc = 'Debug Test' })
vim.keymap.set('n', '<leader>dgl', function() require('dap-go').debug_last_test() end, { desc = 'Debug Last Test' })
vim.keymap.set(
  'n',
  '<leader>dgm',
  function() require('dap').continue { type = 'go', name = 'Debug', request = 'launch', program = '${workspaceFolder}' } end,
  { desc = 'Debug Main' }
)
vim.keymap.set(
  'n',
  '<leader>dgp',
  function()
    require('dap').continue {
      type = 'go',
      name = 'Debug Package',
      request = 'launch',
      program = './${relativeFileDirname}',
    }
  end,
  { desc = 'Debug Package' }
)

-- Setup dap-go automatically
pcall(function() require('dap-go').setup() end)
