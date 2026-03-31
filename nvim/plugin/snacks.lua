vim.pack.add { 'https://github.com/folke/snacks.nvim' }

-- INIT BLOCK
vim.g.snacks_animate = false

-- Create some toggle mappings
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
Snacks.toggle.diagnostics():map '<leader>ud'
Snacks.toggle
  .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map '<leader>uc'
Snacks.toggle.treesitter():map '<leader>uT'
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
Snacks.toggle.inlay_hints():map '<leader>uh'
Snacks.toggle.indent():map '<leader>ug'
Snacks.toggle.dim():map '<leader>uD'

-- Colorizer toggle
local colorizer_toggle = Snacks.toggle.new {
  id = 'colorizer',
  name = 'Colorizer',
  get = function()
    local has_colorizer, colorizer = pcall(require, 'colorizer')
    if not has_colorizer then return false end
    local bufnr = vim.api.nvim_get_current_buf()
    return colorizer.is_buffer_attached(bufnr)
  end,
  set = function(state) pcall(vim.cmd, 'ColorizerToggle') end,
}
colorizer_toggle:map '<leader>ul'

-- Supermaven toggle
local supermaven_toggle = Snacks.toggle.new {
  id = 'supermaven',
  name = 'Supermaven',
  get = function()
    local has_sm, sm = pcall(require, 'supermaven-nvim.api')
    if not has_sm then return false end
    return sm.is_running()
  end,
  set = function(state)
    local has_sm, sm = pcall(require, 'supermaven-nvim.api')
    if not has_sm then return end
    if state then
      sm.start()
    else
      sm.stop()
    end
  end,
}
supermaven_toggle:map '<leader>ua'

-- OPTS BLOCK
require('snacks').setup {
  input = { enabled = true },
  bigfile = { enabled = true },
  lazygit = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  health = { enabled = true },
  image = { enabled = false, inline = false },
  explorer = { enabled = true },
  scratch = { enabled = true },
  indent = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = false },
  styles = { float = { backdrop = false } },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          -- Remap conflicting tmux keybinds
          ['<C-w>w'] = { 'cycle_win', mode = { 'i', 'n' } },
          ['<C-r>r'] = { 'toggle_regex', mode = { 'i', 'n' } },
          ['<C-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
          -- Disable the conflicting ones
          ['<a-w>'] = false,
          ['<a-r>'] = false,
          ['<a-p>'] = false,
        },
      },
    },
    sources = {
      explorer = {
        auto_close = true,
        layout = {
          { preview = true },
          layout = {
            box = 'horizontal',
            width = 0.8,
            height = 0.8,
            {
              box = 'vertical',
              border = 'rounded',
              title = '{source} {live} {flags}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
            },
            { win = 'preview', border = 'rounded', width = 0.6, title = '{preview}' },
          },
        },
        win = {
          list = {
            keys = { ['<Right>'] = 'confirm', ['<Left>'] = 'explorer_close' },
            wo = {
              number = true,
              relativenumber = true,
            },
          },
        },
      },
    },
  },
  dashboard = {
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      {
        align = 'center',
        padding = 1,
        text = { { '󱐋 Loaded 51 plugins via vim.pack', hl = 'footer' } },
      },
    },
    enabled = true,
    preset = {
      header = [[
      )                             
   ( /(                             
   )\())   (        )   (      )    
 ((_)\   ))\  (   /((  )\    (     
   _((_) /((_) )\ (_))\((_)   )\  ' 
 | \| |(_))  ((_)_((_)(_) _((_))  
 | .` |/ -_)/ _ \\ V / | || '  \()
 |_|\_|\___|\___/ \_/  |_||_|_|_|

 @jakmaz • v]] .. tostring(vim.version()) .. [[]],
      keys = {
        { icon = '', key = 'e', desc = 'Explore Files', action = ":lua Snacks.dashboard.pick('explorer')" },
        {
          icon = '',
          key = 'r',
          desc = 'Recent Files',
          action = ':lua Snacks.picker.recent({filter = {cwd = true}})',
        },
        { icon = '', key = 'f', desc = 'Find Files', action = ":lua Snacks.dashboard.pick('files')" },
        { icon = '', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
  },
}

-- KEYS BLOCK
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Top Pickers & Explorer
map('n', '<leader>i', function() Snacks.picker.files() end, { desc = 'Find File' })
map('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
map('n', '<leader>ln', function() Snacks.picker.notifications() end, { desc = 'Notification Picker' })
map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })

-- find
map('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map(
  'n',
  '<leader>fc',
  function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
  { desc = 'Find Config File' }
)
map('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
map('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find Git Files' })
map('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Projects' })
map('n', '<leader>fr', function() Snacks.picker.recent { filter = { cwd = true } } end, { desc = 'Recent' })

-- git
map('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
map('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
map('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
map('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
map('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' }) -- Grep
map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
map('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
map({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })
map('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
map('n', '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
map('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
map('n', '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })

-- search
map('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
map('n', '<leader>ls', function() Snacks.picker.search_history() end, { desc = 'Search History' })
map('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>lc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
map('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
map('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
map('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
map('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
map('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' })
map('n', '<leader>st', function() Snacks.picker.todo_comments() end, { desc = 'Todo comments' })
map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
map('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
map('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- LSP
map('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
map('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
map('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
map('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
map('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
map('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
map('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

-- Other
map('n', '<leader>uz', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
map('n', '<leader>uZ', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
map('n', '<leader>us', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
map('n', '<leader>uS', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
map('n', '<leader>lN', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
map('n', '<C-x>', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
map({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
map('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
map('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
map('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
map({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
map({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })

map(
  'n',
  '<leader>oN',
  function()
    Snacks.win {
      file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
      width = 0.6,
      height = 0.6,
      wo = {
        spell = false,
        wrap = false,
        signcolumn = 'yes',
        statuscolumn = ' ',
        conceallevel = 3,
      },
    }
  end,
  { desc = 'Neovim News' }
)
