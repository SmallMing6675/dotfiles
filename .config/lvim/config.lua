

lvim.plugins = {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...}
}

-- Status line
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location
}
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_x = { "diff" }
lvim.colorscheme = "gruvbox"

vim.wo.relativenumber = true


