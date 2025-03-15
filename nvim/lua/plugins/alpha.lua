return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[

    )                             
 ( /(                             
 )\())   (        )   (      )    
((_)\   ))\  (   /((  )\    (     
 _((_) /((_) )\ (_))\((_)   )\  ' 
| \| |(_))  ((_)_)((_)(_) _((_))  
| .` |/ -_)/ _ \\ V / | || '  \() 
|_|\_|\___|\___/ \_/  |_||_|_|_|  
                                  
	         [ @jakmaz ]
    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
    opts.section.buttons.val = {
      opts.button("e", " " .. " Explore files", "<cmd> Neotree <cr>"),
      opts.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
      opts.button("f", " " .. " Find files", "<cmd> lua LazyVim.pick()() <cr>"),
      opts.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
      opts.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
      opts.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      opts.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      opts.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
  end,
}
