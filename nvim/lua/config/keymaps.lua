-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quit neovim
vim.keymap.set('n', '<leader>q', '<cmd>qa<CR>', { desc = 'Quit All' })

-- Yank whole text
vim.keymap.set('n', '<leader>cy', ':%y+<CR>', { desc = 'Yank Entire Buffer' })

-- Select whole text
vim.keymap.set("n", "<leader>cs", "ggVG", { desc = "Select Entire Buffer" })


-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Lsp actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Function to copy all diagnostics to the clipboard
local function copy_all_diagnostics()
  local diagnostics = vim.diagnostic.get(nil) -- get all diagnostics in current buffer
  if vim.tbl_isempty(diagnostics) then
    vim.notify("No diagnostics to copy!", vim.log.levels.INFO)
    return
  end

  local lines = {}
  for _, d in ipairs(diagnostics) do
    local msg = string.format(
      "[%s] %s:%d:%d: %s",
      vim.diagnostic.severity[d.severity]:sub(1, 1),
      vim.api.nvim_buf_get_name(0),
      d.lnum + 1,
      d.col + 1,
      d.message:gsub("\n", " ")
    )
    table.insert(lines, msg)
  end

  local text = table.concat(lines, "\n")
  vim.fn.setreg("+", text) -- copy to system clipboard
  vim.notify("Diagnostics copied to clipboard!", vim.log.levels.INFO)
end

-- Keymap: <leader>cd to copy all diagnostics
vim.keymap.set(
  "n",
  "<leader>cd",
  copy_all_diagnostics,
  { desc = "Copy All Diagnostics" }
)
