return {
  -- change trouble config
  {
    "nvim-lualine/lualine.nvim",
    -- opts will be merged with the parent spec
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_z = {},
      },
    },
  },
}
