
lvim.colorscheme = "gruvbox-material"

lvim.plugins = {
  { "sainnhe/gruvbox-material",bransh = 'main'},
   {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },
        -- If you have a recent version of lazy.nvim, you don't need to add this!
    build = "nvim -l build/init.lua",

  },
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
lvim.builtin.lualine.options.theme = "gruvbox-material"

vim.wo.relativenumber = true

require("sg").setup {}
