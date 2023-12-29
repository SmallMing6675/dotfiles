vim.wo.relativenumber = true
lvim.colorscheme = "catppuccin-mocha"

lvim.plugins = {
  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000 },
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

