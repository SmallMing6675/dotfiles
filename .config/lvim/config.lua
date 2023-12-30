

lvim.plugins = {
  { "luisiacc/gruvbox-baby",bransh = 'main'}
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
lvim.colorscheme = "gruvbox-baby"
lvim.builtin.lualine.options.theme = "gruvbox-baby"
vim.wo.relativenumber = true
