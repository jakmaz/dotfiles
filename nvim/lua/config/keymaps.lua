-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quit neovim
vim.keymap.set('n', '<leader>q', '<cmd>qa<CR>', { desc = 'Quit All' })

-- Save on Ctrl+S in normal and insert mode, then return to normal mode
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Save File' })

-- Yank whole text
vim.keymap.set('n', '<leader>cy', ':%y+<CR>', { desc = 'Yank Entire Buffer' })

-- Select whole text
vim.keymap.set('n', '<leader>cs', 'ggVG', { desc = 'Select Entire Buffer' })

-- Lsp actions
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename Symbol' })

-- Function to copy all diagnostics to the clipboard
local function copy_all_diagnostics()
  local diagnostics = vim.diagnostic.get(nil) -- get all diagnostics in current buffer
  if vim.tbl_isempty(diagnostics) then
    vim.notify('No diagnostics to copy!', vim.log.levels.INFO)
    return
  end

  local lines = {}
  for _, d in ipairs(diagnostics) do
    local msg = string.format(
      '[%s] %s:%d:%d: %s',
      vim.diagnostic.severity[d.severity]:sub(1, 1),
      vim.api.nvim_buf_get_name(0),
      d.lnum + 1,
      d.col + 1,
      d.message:gsub('\n', ' ')
    )
    table.insert(lines, msg)
  end

  local text = table.concat(lines, '\n')
  vim.fn.setreg('+', text) -- copy to system clipboard
  vim.notify('Diagnostics copied to clipboard!', vim.log.levels.INFO)
end

-- Keymap: <leader>cd to copy all diagnostics
vim.keymap.set('n', '<leader>cd', copy_all_diagnostics, { desc = 'Copy All Diagnostics' })

-- Center screen after scrolling or searching (from prime)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

-- Map Ctrl-h and Ctrl-k to replicate default actions of Ctrl-o and Ctrl-i which are used by harpoon
vim.keymap.set('n', '<C-h>', '<C-o>', { desc = 'Jump back in jump list (same as Ctrl-o)' })
vim.keymap.set('n', '<C-k>', '<C-i>', { desc = 'Jump forward in jump list (same as Ctrl-i)' })

-- Map Ctrl-a to switch to the last buffer
vim.keymap.set('n', '<C-a>', '<C-^>', { desc = 'Switch to last buffer' })

-- Bind "(" for navigating to the previous error diagnostic using the new API
vim.keymap.set('n', '(', function()
  vim.diagnostic.jump {
    count = -1, -- Negative count moves to the previous diagnostic
    severity = vim.diagnostic.severity.ERROR, -- Filter diagnostics by severity
    float = true, -- Show diagnostics in a floating window
  }
end, { desc = 'Go to previous error diagnostic' })

-- Bind ")" for navigating to the next error diagnostic using the new API
vim.keymap.set('n', ')', function()
  vim.diagnostic.jump {
    count = 1, -- Positive count moves to the next diagnostic
    severity = vim.diagnostic.severity.ERROR, -- Filter diagnostics by severity
    float = true, -- Show diagnostics in a floating window
  }
end, { desc = 'Go to next error diagnostic' })
