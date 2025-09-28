return {
  'monaqa/dial.nvim',
  keys = {
    { '<C-+>', function() require('dial.map').manipulate('increment', 'normal') end, desc = 'Increment' },
    { '<C-->', function() require('dial.map').manipulate('decrement', 'normal') end, desc = 'Decrement' },
    { '<C-+>', function() require('dial.map').manipulate('increment', 'visual') end, mode = 'v', desc = 'Increment' },
    { '<C-->', function() require('dial.map').manipulate('decrement', 'visual') end, mode = 'v', desc = 'Decrement' },
  },
  config = function()
    local augend = require 'dial.augend'

    require('dial.config').augends:register_group {
      default = {
        -- Numbers
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,

        -- Booleans
        augend.constant.alias.bool,

        -- Dates
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d/%Y'],
        augend.date.alias['%H:%M:%S'],
        augend.date.alias['%H:%M'],

        -- Hex colors
        augend.hexcolor.new {
          case = 'lower',
        },
        augend.hexcolor.new {
          case = 'upper',
        },

        -- Semantic versioning
        augend.semver.alias.semver,

        -- Common constants
        augend.constant.new {
          elements = { 'and', 'or' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { '&&', '||' },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'let', 'const', 'var' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'public', 'private', 'protected' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'yes', 'no' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'on', 'off' },
          word = true,
          cyclic = true,
        },
      },
    }
  end,
}
