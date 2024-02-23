-- Setup lazy and load all of the plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		import = "plugins",

		performance = {
			cache = {
				enabled = true,
			},
			rtp = {
				disabled_plugins = {
					-- "matchit",
					-- "matchparen",
					"netrwPlugin",
					"gzip",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	},
})

vim.cmd("silent TSUpdate")
