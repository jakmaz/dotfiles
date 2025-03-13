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
  end,
}
