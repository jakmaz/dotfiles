return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  -- stylua: ignore
  keys = {
    { "<CR>",  mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
  config = function()
    -- Load your colorscheme FIRST (if not already loaded globally)
    -- vim.cmd("colorscheme tokyonight") -- Replace with your colorscheme, if needed

    -- Configure Flash labels
    require("flash").setup {
      labels = "arstgmneio"
    }

    -- Now, customize Flash colors
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bold = true })
  end,
}
