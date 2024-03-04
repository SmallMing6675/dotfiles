vim.loader.enable()

vim.g.mapleader = " "
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20
vim.g.python3_host_prog = vim.loop.os_homedir() .. "/.virtualenvs/neovim/bin/python3"

local map = vim.keymap.set

------------ Configuration for neovim itself -------------
local options = {
	expandtab = true,
	tabstop = 4,
	shiftwidth = 4,
	nu = true,
	relativenumber = true,
	numberwidth = 4,
	cursorline = true,
	updatetime = 300,
	timeoutlen = 0,
	ignorecase = true,
	incsearch = true,
	shadafile = "NONE",
	wrap = false,
	clipboard = "unnamedplus",
	cmdheight = 0,
	fillchars = {
		eob = " ",
	},
	shell = "/bin/bash",
	swapfile = false,
	laststatus = 3,
}

for o, v in pairs(options) do
	vim.opt[o] = v
end
---------- keymaps ----------
map("n", ";", ":")
map("n", "<leader>/", "gcc", { desc = "Comment line" })
map("n", "<leader>n", ":ene <BAR> startinsert <CR>", { desc = "New File" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map("n", "<Leader>q", ":wq<CR>", { desc = "Save Then Exit" })
map("n", "<Leader>x", ":q<CR>", { desc = "Exit" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "Open Vertical Split" })
map("n", "<leader>h", ":split<CR>", { desc = "Open Horizontal Split" })
map("n", "<leader>q", "<Cmd>wq<CR>", { desc = "Close Buffer" })
map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })
map("n", "<C-j>", "<Cmd>bp<CR>", { desc = "Go to previous Buffer" })
map("n", "<C-k>", "<Cmd>bn<CR>", { desc = "Go to Next Buffer" })
map("n", "<leader>C", "ggVG<cr>", { desc = "Select all text" })

map("n", "=", "<cmd>horizontal resize +10<cr>", { desc = "Resize Window Up" })
map("n", "-", "<cmd>horizontal resize -10<cr>", { desc = "Resize Window Down" })
map("n", "+", "<cmd>vertical resize +10<cr>", { desc = "Resize Window Left" })
map("n", "_", "<cmd>vertical resize -10<cr>", { desc = "Resize Window Right" })

map("n", "<A-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<A-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<A-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<A-l>", "<C-w>l", { desc = "Window Right" })

map("n", "<C-l>", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<C-h>", "<cmd>tabprevious<CR>", { desc = "Tab: Previous " })
map("n", "<tab>n", "<cmd>tabnew<CR>", { desc = "Tab: New" })
map("n", "<tab>j", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<tab>k", "<cmd>tabprevious<CR>", { desc = "Tab: Previous " })
map("n", "<tab>x", "<cmd>tabclose<CR>", { desc = "Tab: Close " })
map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { desc = "Add line below" })
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { desc = "Add line above" })
map("n", "J", "<C-d>")
map("n", "K", "<C-u>")

---------- plugins ----------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugins = {
	"nathom/filetype.nvim",
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
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
		event = "VimEnter",
		cmd = "TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = { "rust", "python", "c", "lua", "vim", "vimdoc", "query" },
				auto_install = true,
			})
			vim.cmd("silent TSUpdate")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		keys = {
			{ "<a-u>", "<cmd>Telescope undo<cr>", desc = "Undo History" },
			{ "<a-f>", "<Cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<a-r>", "<Cmd>Telescope oldfiles<CR>", desc = "Find Recent Files" },
			{ "<a-g>", "<Cmd>Telescope live_grep<CR>", desc = "Find Grep" },

			{ "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
			{ "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
			{ "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
			{ "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Find oldfiles" },
			{ "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
			{ "<leader>fc", "<cmd> Telescope git_commits <CR>", desc = "Git commits" },
			{ "<leader>fs", "<cmd> Telescope git_status <CR>", desc = "Git status" },
		},
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				pickers = { find_files = { follow = true } },
				defaults = { border = true },
				extensions = { file_browser = { hijack_netrw = true } },
			})
			require("telescope").load_extension("undo")
		end,
	},
	{
		"sbdchd/neoformat",
		event = "BufWritePre",
		config = function()
			vim.g.neoformat_c_clangformat = { exe = "clang-format", args = { "--style=Webkit" } }
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = { "williamboman/mason-lspconfig", "williamboman/mason.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "rust_analyzer", "clangd" } })
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = { { "<leader>p", "<cmd>Outline<CR>", desc = "Toggle outline" } },
		config = function()
			require("outline").setup({
            -- stylua: ignore
            symbols = { icons = { File = { icon = "󰈙",hl = "Identifier"},Module = {icon = "󰆧",hl = "Include"},Namespace = {icon = "󰅪",hl = "Include"},Package = {icon = "󰏗",hl = "Include"},Class = {icon = "󰠱",hl = "Type"},Method = {icon = "󰊕",hl = "Function"},Property = {icon = "󰜢",hl = "Identifier"},Field = {icon = "󰇽",hl = "Identifier"},Constructor = {icon = "",hl = "Special"},Enum = {icon = "",hl = "Type"},Interface = {icon = "",hl = "Type"},Function = {icon = "󰊕",hl = "Function"},Variable = {icon = "",hl = "Constant"},Constant = {icon = "",hl = "Constant"},String = {icon = "",hl = "String"},Number = {icon = "#",hl = "Number"},Boolean = {icon = "⊨",hl = "Boolean"},Array = {icon = "󰅪",hl = "Constant"},Object = {icon = "⦿",hl = "Type"},Key = {icon = "",hl = "Type"},Null = {icon = "󰟢",hl = "Type"},EnumMember = {icon = "",hl = "Identifier"},Struct = {icon = "",hl = "Structure"},Event = {icon = "",hl = "Type"},Operator = {icon = "+",hl = "Identifier"},TypeParameter = {icon = "󰅲",hl = "Identifier"},Component = {icon = "󰅴",hl = "Function"},Fragment = {icon = "󰅴",hl = "Constant"},TypeAlias = {icon = "",hl = "Type"},Parameter = {icon = "",hl = "Identifier"},StaticMethod = {icon = "",hl = "Function"},Macro = {icon = "",hl = "Function"}}},
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
            -- stylua: ignore
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
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer", max_item_count = 3 },
					{ name = "luasnip", max_item_count = 5 },
				},
				window = {
					completion = { border = "shadow" },
					documentation = { border = "shadow" },
				},
			})

			cmp.setup.cmdline(
				{ "/", "?" },
				{ mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } }
			)
			cmp.setup.cmdline(
				":",
				{ mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = "cmdline" } }) }
			)

			vim.cmd("hi CmpNormal guibg=#1A2224")
			vim.cmd("hi CmpItemAbbr guibg=none")
			vim.cmd("hi CmpItemKind guibg=none")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local everblush = require("lualine.themes.everblush")
			everblush.normal.c.bg = "#232a2d"
			everblush.normal.b.bg = "#2d3437"

	        -- stylua: ignore
	        local files = { {"filename", symbols = {modified = "󱇧", readonly = "",unnamed = "󰲶", newfile = ""} } }
			require("lualine").setup({
				sections = {
					lualine_b = files,
					lualine_c = { "diagnostics" },
					lualine_x = { "filetype" },
					lualine_y = { "tabs" },
				},
				options = { theme = everblush, section_separators = { left = "", right = "" } },
				extensions = { "fzf", "lazy", "neo-tree", "fzf", "toggleterm" },
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "UIEnter",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = { presets = { command_palette = true, lsp_doc_border = false, long_message_to_split = true } },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = { window = { position = "right", width = 30 } },
		keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Tree" } },
	},
	{
		"echasnovski/mini.nvim",
		event = "UIEnter",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.animate").setup()
		end,
	},
	{
		"toppair/reach.nvim",
		config = function()
			require("reach").setup({ notifications = true })
		end,
		keys = { { "`", "<cmd>ReachOpen buffers<CR>", desc = "Open Reach" } },
	},
	{
		"Everblush/nvim",
		lazy = false,
		name = "everblush",
		config = function()
			vim.cmd.colorscheme("everblush")
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "c", "v", "g" },
		config = function()
			local which_key = require("which-key")
			which_key.setup({
				window = {
					border = "shadow",
					position = "bottom",
				},
				layout = { align = "center" },
			})
			which_key.register({
				["<leader>l"] = { name = "+LSP" },
				["<leader>f"] = { name = "+Telescope" },
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "UIEnter",
		main = "ibl",
		opts = { scope = { enabled = false }, indent = { highlight = "LineNr" } },
	},
	{
		"folke/flash.nvim",
		opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
}

--stylua: ignore
require("lazy").setup({
	spec = plugins,
	defaults = { lazy = true, version = false, config = true, event = "VeryLazy" },

	performance = {
		cache = { enabled = true },
		rtp = { disabled_plugins = { "2html_plugin", "bugreport", "compiler", "ftplugin", "getscript", "getscriptPlugin", "gzip", "logipat", "matchit", "netrw", "netrwFileHandlers", "netrwPlugin", "netrwSettings", "optwin", "rplugin", "rrhelper", "spellfile_plugin", "synmenu", "syntax", "tar", "tarPlugin", "tohtml", "tutor", "vimball", "vimballPlugin", "zip", "zipPlugin", "editorconfig", "man", "health", "matchparen", "spellfile", "shada", }, },
    },
})
---------- autocmds ---------0
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
	callback = function()
		vim.cmd.Neoformat()
	end,
})
autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})
autocmd("UIEnter", {
	callback = function()
		vim.cmd("hi LineNr guifg=#404749")
		vim.cmd("hi CursorLineNr guifg=fg")
		vim.cmd("hi CursorLine guibg=none")
		vim.cmd("hi VertSplit guifg=#232A2D")
		vim.cmd("hi TelescopeSelection guifg=#6cbfbf guibg=bg")
	end,
})
autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})
autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
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
