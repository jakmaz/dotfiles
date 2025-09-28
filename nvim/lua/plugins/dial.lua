return {
  'monaqa/dial.nvim',
  keys = {
    { '<C-]>', function() return require('dial.map').inc_normal() end, expr = true, desc = 'Increment' },
    { '<C-_>', function() return require('dial.map').dec_normal() end, expr = true, desc = 'Decrement' },
    { '<C-]>', function() return require('dial.map').inc_visual() end, mode = 'v', expr = true, desc = 'Increment' },
    { '<C-_>', function() return require('dial.map').dec_visual() end, mode = 'v', expr = true, desc = 'Decrement' },
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
