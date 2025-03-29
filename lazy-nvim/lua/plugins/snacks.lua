return {

  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        header = [[
      )                             
  ( /(                             
  )\())   (        )   (      )    
((_)\   ))\  (   /((  )\    (     
  _((_) /((_) )\ (_))\((_)   )\  ' 
| \| |(_))  ((_)_)((_)(_) _((_))  
| .` |/ -_)/ _ \\ V / | || '  \() 
|_|\_|\___|\___/ \_/  |_||_|_|_|  
                                  
[ @jakmaz ]
]],

        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "o", desc = "Open in Finder", action = ":lua vim.fn.system('^open .')" },
          { icon = " ", key = "e", desc = "Explore Files", action = ":lua Snacks.dashboard.pick('explorer')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "f", desc = "Find Files", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
