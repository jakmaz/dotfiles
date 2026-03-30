vim.pack.add({ 'https://github.com/monaqa/dial.nvim' })

local augend = require 'dial.augend'
require('dial.config').augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias['%Y/%m/%d'],
  },
  typescript = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.new { elements = { 'let', 'const' } },
    augend.constant.new { elements = { 'true', 'false' } },
  },
  visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias['%Y/%m/%d'],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
  mygroup = {
    augend.constant.new { elements = { 'and', 'or' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'True', 'False' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'public', 'private', 'protected' }, word = true, cyclic = true },
  },
}

vim.keymap.set('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end)
vim.keymap.set('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end)
vim.keymap.set('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end)
vim.keymap.set('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end)
vim.keymap.set('v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end)
vim.keymap.set('v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end)
vim.keymap.set('v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end)
vim.keymap.set('v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end)
