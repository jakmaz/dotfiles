return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      enabled = true,
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

        keys = {
          { icon = ' ', key = 'e', desc = 'Explore Files', action = ":lua Snacks.dashboard.pick('explorer')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'f', desc = 'Find Files', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
  },
}
