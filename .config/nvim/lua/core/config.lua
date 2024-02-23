----------------------------------
-- Setup any configuration here --
----------------------------------

-- sets the leader key to space
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- tab size
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.cursorline = true

vim.opt.lazyredraw = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- disable line wrapping
vim.cmd([[
set nowrap
set clipboard+=unnamedplus
set cmdheight=0
set fillchars+=eob:\ 

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    augroup END

set noswapfile]])
