return { 
  "catppuccin/nvim",
  name = "catppuccin", 
  priority = 1000 ,
  config=function()
    require("catppuccin").setup({
      flavors="macchiato",
      integrations = {
        which_key = true,
        treesitter = true,
        telescope = {
          enabled = true,
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}
