return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { statusline = { 'snacks_dashboard' } },
    },

    sections = {
      lualine_a = {},
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = {
        -- Harpoon files
        {
          function()
            local harpoon = require 'harpoon'
            local list = harpoon:list()
            local items = list.items

            if #items == 0 then return '' end

            local result = {}
            for i = 1, math.min(4, #items) do
              local item = items[i]
              if item and item.value then
                local filename = vim.fn.fnamemodify(item.value, ':t')
                table.insert(result, filename)
              end
            end

            return table.concat(result, ' | ')
          end,
          color = function()
            local harpoon = require 'harpoon'
            local list = harpoon:list()
            if #list.items > 0 then
              return nil
            else
              return 'Comment'
            end
          end,
        },
        -- Supermaven status
        {
          function()
            local toggle = Snacks.toggle.get 'supermaven'
            if toggle and toggle:get() then
              return '󰚩'
            else
              return '󰚩'
            end
          end,
          color = function()
            local toggle = Snacks.toggle.get 'supermaven'
            if toggle and toggle:get() then
              return nil -- use default lualine text color
            else
              return 'Comment'
            end
          end,
        },
        -- LSP status
        {
          function()
            local clients = vim.lsp.get_clients { bufnr = 0 }
            if #clients == 0 then
              return '󰒋'
            else
              return '󰒋'
            end
          end,
          color = function()
            local clients = vim.lsp.get_clients { bufnr = 0 }
            if #clients > 0 then
              return nil
            else
              return 'Comment'
            end
          end,
        },
        -- Formatter status
        {
          function()
            local conform = require 'conform'
            local formatters = conform.list_formatters(0)
            if #formatters > 0 then
              return '󰉣'
            else
              return '󰉣'
            end
          end,
          color = function()
            local conform = require 'conform'
            local formatters = conform.list_formatters(0)
            if #formatters > 0 then
              return nil
            else
              return 'Comment'
            end
          end,
        },
        -- Linter status
        {
          function()
            local lint = require 'lint'
            local linters = lint.linters_by_ft[vim.bo.filetype] or {}
            if #linters > 0 then
              return '󰁨'
            else
              return '󰁨'
            end
          end,
          color = function()
            local lint = require 'lint'
            local linters = lint.linters_by_ft[vim.bo.filetype] or {}
            if #linters > 0 then
              return nil
            else
              return 'Comment'
            end
          end,
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { 'lazy', 'mason', 'neo-tree' },
  },
}
