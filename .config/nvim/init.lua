vim.loader.enable()

vim.g.mapleader = " "
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

------------ Configuration -------------
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.nu = true
opt.relativenumber = true
opt.numberwidth = 4
opt.updatetime = 300
opt.timeoutlen = 0
opt.shadafile = "NONE"
opt.clipboard = "unnamedplus"
opt.showtabline = 0
opt.ch = 0
opt.scrolloff = 8
opt.wrap = false
opt.laststatus = 3
opt.shell = "/bin/bash"
opt.cursorline = true

vim.wo.foldmethod = "expr"
vim.wo.foldnestmax = 3
vim.wo.foldlevel = 99

---------- keymaps ----------
map({ "n", "v" }, "Q", "<Nop>")
map("n", ";", ":")
map("n", "<leader>/", "gcc", { desc = "Comment line" })
map("n", "<leader>n", ":ene <BAR> startinsert <CR>", { desc = "New File" })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>q", ":wq<cr>", { desc = "save then exit" })
map("n", "<leader>x", ":bdelete<cr>", { desc = "delete buffer" })
map("n", "<leader>v", ":vsplit<cr>", { desc = "open vertical split" })
map("n", "<leader>h", ":split<cr>", { desc = "open horizontal split" })
map("n", "<leader>q", "<cmd>wq<cr>", { desc = "close buffer" })
map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })
map("n", "<", "V<", { desc = "Indent Line Normal" })
map("n", ">", "V>", { desc = "Indent Line Normal" })
map("n", "<leader>C", "ggVG<cr>", { desc = "Select all text" })
map("n", "=", "<cmd>horizontal resize +10<cr>", { desc = "Resize Window Up" })
map("n", "-", "<cmd>horizontal resize -10<cr>", { desc = "Resize Window Down" })
map("n", "+", "<cmd>vertical resize +10<cr>", { desc = "Resize Window Left" })
map("n", "_", "<cmd>vertical resize -10<cr>", { desc = "Resize Window Right" })
map("n", "<A-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<A-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<A-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<A-l>", "<C-w>l", { desc = "Window Right" })
map({ "n", "v" }, "J", "<C-d>")
map({ "n", "v" }, "K", "<C-u>")
map("n", "<A-S-l>", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<A-S-h>", "<cmd>tabprevious<CR>", { desc = "Tab: Previous" })
map("n", "<leader><Tab>", "<cmd>tabnew<CR>", { desc = "Tab: Next" })

---------- autocmds ---------
autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})
autocmd("BufWritePre", {
	callback = function()
		vim.cmd.Neoformat()
	end,
})
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})
autocmd("LspAttach", {
	callback = function(_)
		map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
		map("n", "<leader>lm", vim.lsp.buf.format, { desc = "LSP: Format" })
		map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
		map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
		map("n", "<leader>lf", vim.lsp.buf.references, { desc = "LSP: Find References" })
		map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
	end,
})

---------- plugins ----------
local plugins = {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				show_eob = false,
				background = "hard",
				on_highlights = function(hl, palette)
					hl.WinSeparator = { fg = palette.bg0, bg = palette.bg0 }
				end,
			})
			require("everforest").load()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			indent = {
				indent_size = 4,
			},
		},
		keys = {
			{
				"<leader>e",
				"<Cmd>Neotree toggle<CR>",
				desc = "Toggle File Tree",
			},
		},
	},
	{
		"NvChad/nvterm",
		keys = {
			{
				"<leader>t",
				function()
					require("nvterm.terminal").toggle("float")
				end,
				desc = "Toggle Terminal",
			},
		},
		opts = {
			terminals = {
				shell = "fish",
				type_opts = { float = { row = 0.2, width = 0.6, col = 0.2, height = 0.6, border = "none" } },
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "UIEnter",
		main = "ibl",
		config = function()
			local highlight = { "LineNr" }
			require("ibl").setup({
				indent = { highlight = highlight },
				scope = { enabled = false },
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = {
						{
							"mode",
							icons_enabled = true,
							icon = "",
						},
					},
					lualine_x = {
						{ "branch", icon = "󰊤" },
					},
					lualine_y = {
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
							colored = true,
							padding = 1,
						},
					},

					lualine_b = { { "windows", padding = 1 } },
					lualine_c = {
						{
							function()
								return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
							end,
							padding = 0,
							icon = " ",
						},
					},
					lualine_z = { { "tabs", padding = 1.5, symbols = { modified = " 󱇧" } } },
				},
				options = {
					theme = "everforest",

					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "󰍵" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = { "rust", "python", "c", "lua", "vim", "vimdoc", "query" },
			})

			vim.cmd("silent TSUpdate")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = { user_default_options = { names = false } },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<a-f>", "<Cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<a-r>", "<Cmd>Telescope oldfiles<CR>", desc = "Find Recent Files" },
			{ "<a-g>", "<Cmd>Telescope live_grep<CR>", desc = "Find Grep" },
			{ "<a-b>", "<Cmd>Telescope buffers<CR>", desc = "Find Buffers" },
		},
		cmd = "Telescope",
		opts = {
			pickers = { find_files = { follow = true } },
			defaults = { border = false },
			extensions = {
				file_browser = { hijack_netrw = true },
			},
		},
	},
	{
		"sbdchd/neoformat",
		cmd = "Neoformat",
		config = function()
			vim.g.neoformat_c_clangformat = { exe = "clang-format", args = { "--style=Webkit" } }
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"williamboman/mason-lspconfig",
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
            -- stylua: ignore
			require("mason-tool-installer").setup({ ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pyright", "stylua", "blackd-client", "autopep8", "prettier", "clang-format" }, })
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
            --stylua: ignore
            local kind_icons = { Text = "", Method = "󰆧", Function = "󰊕", Constructor = "", Field = "󰇽", Variable = "", Class = "󰠱", Interface = "", Module = "", Property = "󰜢", Unit = "", Value = "", Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘", File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "", Constant = "", Struct = "", Event = "", Operator = "󰆕", TypeParameter = "󰅲", Codeium = "" }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = { { name = "luasnip" }, { name = "nvim_lsp" }, { name = "buffer", max_item_count = 5 } },
				window = {
					completion = { border = "shadow", winhighlight = "Normal:CmpNormal" },
					documentation = { border = "shadow" },
				},
			})

			cmp.setup.cmdline(
				":",
				{ mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = "cmdline" } }) }
			)
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "UIEnter",
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		event = "VimEnter",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.pairs").setup()
			require("mini.comment").setup()
			if not vim.g.neovide then
				require("mini.animate").setup()
			end
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({ indent_lines = false })
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "c", "v", "g", "<tab>" },
		config = function()
			local which_key = require("which-key")
			which_key.setup({ window = { border = "shadow", position = "bottom" }, layout = { align = "center" } })
			which_key.register({ ["<leader>l"] = { name = "+LSP" }, ["<leader>f"] = { name = "+Telescope" } })
		end,
	},
	{
		"folke/noice.nvim",
		event = "UIEnter",
		opts = { cmdline = { enabled = true } },
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"folke/flash.nvim",
		opts = {},
        -- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash", },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
			{ "<a-s>", mode = { "n", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
			{ "<c-s>", mode = { "n" }, function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end, desc = "Flash Current Word", },
		},
	},
	{
		"NStefan002/15puzzle.nvim",
		cmd = "Play15puzzle",
		config = function()
			require("15puzzle").setup({
				keys = {
					up = "w",
					down = "s",
					left = "a",
					right = "d",
					new_game = "N",
					confirm = "y",
					cancel = "n",
					next_theme = "<c-a>",
					prev_theme = "<c-x>",
				},
			})
		end,
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


-- stylua: ignore
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

--stylua: ignore
require("lazy").setup({
    spec = plugins,
    defaults = { lazy = true, version = false, config = true, event = "VeryLazy" },
    performance = {
        cache = { enabled = true },
        rtp = { disabled_plugins = { "2html_plugin", "bugreport", "compiler", "ftplugin", "getscript", "getscriptPlugin", "gzip", "logipat", "matchit", "netrw", "netrwFileHandlers", "netrwPlugin", "netrwSettings", "optwin", "rplugin", "rrhelper", "spellfile_plugin", "synmenu", "syntax", "tar", "tarPlugin", "tohtml", "tutor", "vimball", "vimballPlugin", "zip", "zipPlugin", "editorconfig", "man", "health", "matchparen", "spellfile", "shada", }, },
    },
})

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h16"

	vim.g.neovide_scale_factor = 1
	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 4
	vim.g.neovide_padding_right = 15
	vim.g.neovide_padding_left = 15

	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_vfx_mode = "railgun"
end
