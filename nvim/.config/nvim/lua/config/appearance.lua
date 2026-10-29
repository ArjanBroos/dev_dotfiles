require("kanagawa").setup({
  theme = "dragon",
  transparent = true,
})
vim.cmd.colorscheme("kanagawa-dragon")

require("lualine").setup({
  options = {
    theme = "kanagawa",
  },
  sections = {
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      "filename",
    },
    lualine_x = {},
    lualine_y = {},
  },
})
