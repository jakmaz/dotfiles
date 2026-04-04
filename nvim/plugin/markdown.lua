vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

-- Start disabled by default
require('render-markdown').setup({
  enabled = false,
})

-- Create Snacks toggle after all plugins are loaded
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if not Snacks then
      vim.notify('Snacks not loaded, cannot create markdown toggle', vim.log.levels.WARN)
      return
    end

    local markdown_toggle = Snacks.toggle.new {
      id = 'markdown',
      name = 'Markdown Rendering',
      get = function()
        local has_md, md = pcall(require, 'render-markdown')
        if not has_md then return false end
        return md.get()
      end,
      set = function(state)
        local has_md, md = pcall(require, 'render-markdown')
        if not has_md then return end
        md.set(state)
      end,
    }
    markdown_toggle:map '<leader>um'
  end,
})
