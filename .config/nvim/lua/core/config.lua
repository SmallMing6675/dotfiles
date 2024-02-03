----------------------------------
-- Setup any configuration here --
----------------------------------

-- sets the leader key to space
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- disable line wrapping
vim.cmd(":set nowrap")

-- set the clipboard to default system clipboard
-- requires a clipboard to be installed on your system
vim.cmd("set clipboard+=unnamedplus")

-- disable the command bar
vim.cmd("set cmdheight=0")

-- Disable ~ at the end of the file
vim.cmd("set signcolumn=no")
vim.opt.fillchars:append("eob: ")

-- highlight on yank
vim.cmd([[  
	augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
	augroup END
]])
