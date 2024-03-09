vim.loader.enable()

vim.g.mapleader = " "
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

local map = vim.keymap.set
------------ Configuration for neovim itself -------------
local options = {
	expandtab = true,
	tabstop = 4,
	shiftwidth = 4,
	nu = true,
	relativenumber = true,
	numberwidth = 4,
	updatetime = 300,
	timeoutlen = 0,
	ignorecase = true,
	shadafile = "NONE",
	clipboard = "unnamedplus",
	fillchars = { eob = " " },
	showtabline = 0,
	scrolloff = 8,
	wrap = true,
	laststatus = 3,
	shell = "/bin/bash",
	swapfile = false, -- disables swap file, remove this line if you don't want this
}

for o, v in pairs(options) do
	vim.opt[o] = v
end
---------- keymaps ----------
local keymaps = {
	{ ";", ":" },
	{ "<leader>/", "gcc", "Comment line" },
	{ "<leader>n", ":ene <BAR> startinsert <CR>", "New File" },
	{ "<esc>", "<cmd>noh<cr><esc>", { "Escape and clear hlsearch" } },
	{ "<a-q>", "<Esc><Esc>" },

	{ "<Leader>q", ":wq<CR>", "Save Then Exit" },
	{ "<Leader>x", ":q<CR>", "Exit" },
	{ "<leader>v", ":vsplit<CR>", "Open Vertical Split" },
	{ "<leader>h", ":split<CR>", "Open Horizontal Split" },
	{ "<leader>q", "<Cmd>wq<CR>", "Close Buffer" },
	{ { v = "<" }, "<gv", "Indent Line" },
	{ { v = ">" }, ">gv", "Indent Line" },
	{ "<C-j>", "<Cmd>bp<CR>", "Go to previous Buffer" },
	{ "<C-k>", "<Cmd>bn<CR>", "Go to Next Buffer" },
	{ "<leader>C", "ggVG<cr>", "Select all text" },

	{ "=", "<cmd>horizontal resize +10<cr>", "Resize Window Up" },
	{ "-", "<cmd>horizontal resize -10<cr>", "Resize Window Down" },
	{ "+", "<cmd>vertical resize +10<cr>", "Resize Window Left" },
	{ "_", "<cmd>vertical resize -10<cr>", "Resize Window Right" },

	{ "<A-h>", "<C-w>h", "Window Left" },
	{ "<A-j>", "<C-w>j", "Window Down" },
	{ "<A-k>", "<C-w>k", "Window Up" },
	{ "<A-l>", "<C-w>l", "Window Right" },

	{ "<C-l>", "<cmd>tabnext<CR>", "Tab: Next" },
	{ "<C-h>", "<cmd>tabprevious<CR>", "Tab: Previous " },
	{ "<tab>n", "<cmd>tabnew<CR>", "Tab: New" },
	{ "<tab>j", "<cmd>tabnext<CR>", "Tab: Next" },
	{ "<tab>k", "<cmd>tabprevious<CR>", "Tab: Previous " },
	{ "<tab>x", "<cmd>tabclose<CR>", "Tab: Close " },
	{ "J", "<C-d>" },
	{ "K", "<C-u>" },
}

for _, mapping in ipairs(keymaps) do
	if type(mapping[1]) == "table" then
		for key, value in pairs(mapping[1]) do
			map(key, value, mapping[2], { desc = mapping[3] })
		end
	else
		map("n", mapping[1], mapping[2], { desc = mapping[3] })
	end
end

---------- autocmds ---------0
local autocmds = {

	{
		"VimEnter",
		function()
			if vim.fn.argv(0) == "" then
				require("telescope.builtin").find_files()
			end
		end,
	},
	{
		"UIEnter",
		function()
			vim.cmd("hi LineNr guifg=#404749")
			vim.cmd("hi VertSplit guifg=#232A2D")
			vim.cmd("hi TelescopeSelection guifg=#8ccf7e guibg=bg")
			vim.cmd("hi FlashLabel guifg=fg")
		end,
	},
	{
		"TextYankPost",
		function()
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
		end,
	},
	{
		"LspAttach",
		function(_)
			map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
			map("n", "<leader>lm", vim.lsp.buf.format, { desc = "LSP: Format" })
			map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
			map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
			map("n", "<leader>lf", vim.lsp.buf.references, { desc = "LSP: Find References" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
		end,
	},
}
for _, autocmd in ipairs(autocmds) do
	vim.api.nvim_create_autocmd(autocmd[1], {
		callback = autocmd[2],
	})
end

---------- plugins ----------
local plugins = {
	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
		config = function()
			local everblush = require("lualine.themes.everblush")
			everblush.normal.c.bg = "#1a2224"
			everblush.normal.b.bg = "#1a2224"

			require("lualine").setup({
				sections = {
					lualine_x = { "branch" },
					lualine_y = {},
					lualine_c = {
						{
							"lsp_progress",
							display_components = { "lsp_client_name", { "title", "percentage" } },
						},
					},
					lualine_b = {
						{
							"windows",
							symbols = { modified = " 󱇧", readonly = " ", unnamed = " 󰲶", newfile = " " },
						},
					},
					lualine_z = { "tabs" },
				},
				options = {
					theme = everblush,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				extensions = { "fzf", "lazy", "neo-tree", "fzf", "toggleterm" },
			})
		end,
	},
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
		event = "UIEnter",
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
			{ "<a-u>", "<cmd>Telescope undo<cr>", "Undo History" },
			{ "<a-f>", "<Cmd>Telescope find_files<CR>", "Find Files" },
			{ "<a-r>", "<Cmd>Telescope oldfiles<CR>", "Find Recent Files" },
			{ "<a-g>", "<Cmd>Telescope live_grep<CR>", "Find Grep" },

			{ "<leader>ff", "<cmd> Telescope find_files <CR>", "Find files" },
			{ "<leader>fw", "<cmd> Telescope live_grep <CR>", "Live grep" },
			{ "<leader>fb", "<cmd> Telescope buffers <CR>", "Find buffers" },
			{ "<leader>fh", "<cmd> Telescope help_tags <CR>", "Help page" },
			{ "<leader>fo", "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
			{ "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
			{ "<leader>fc", "<cmd> Telescope git_commits <CR>", "Git commits" },
			{ "<leader>fs", "<cmd> Telescope git_status <CR>", "Git status" },
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
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					vim.cmd.Neoformat()
				end,
			})

			vim.g.neoformat_c_clangformat = { exe = "clang-format", args = { "--style=Webkit" } }
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"williamboman/mason-lspconfig",
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
            -- stylua: ignore
			require("mason-tool-installer").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pyright", "stylua", "blackd-client", "autopep8", "prettier", "clang-format" },
			})
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
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = { { "<leader>p", "<cmd>Outline<CR>", desc = "Toggle outline" } },
		config = function()
			require("outline").setup({
                -- stylua: ignore
                symbols = { icons = { File = { icon = "󰈙", hl = "Identifier" }, Module = { icon = "󰆧", hl = "Include" }, Namespace = { icon = "󰅪", hl = "Include" }, Package = { icon = "󰏗", hl = "Include" }, Class = { icon = "󰠱", hl = "Type" }, Method = { icon = "󰊕", hl = "Function" }, Property = { icon = "󰜢", hl = "Identifier" }, Field = { icon = "󰇽", hl = "Identifier" }, Constructor = { icon = "", hl = "Special" }, Enum = { icon = "", hl = "Type" }, Interface = { icon = "", hl = "Type" }, Function = { icon = "󰊕", hl = "Function" }, Variable = { icon = "", hl = "Constant" }, Constant = { icon = "", hl = "Constant" }, String = { icon = "", hl = "String" }, Number = { icon = "#", hl = "Number" }, Boolean = { icon = "⊨", hl = "Boolean" }, Array = { icon = "󰅪", hl = "Constant" }, Object = { icon = "⦿", hl = "Type" }, Key = { icon = "", hl = "Type" }, Null = { icon = "󰟢", hl = "Type" }, EnumMember = { icon = "", hl = "Identifier" }, Struct = { icon = "", hl = "Structure" }, Event = { icon = "", hl = "Type" }, Operator = { icon = "+", hl = "Identifier" }, TypeParameter = { icon = "󰅲", hl = "Identifier" }, Component = { icon = "󰅴", hl = "Function" }, Fragment = { icon = "󰅴", hl = "Constant" }, TypeAlias = { icon = "", hl = "Type" }, Parameter = { icon = "", hl = "Identifier" }, StaticMethod = { icon = "", hl = "Function" }, Macro = { icon = "", hl = "Function" } } },
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
				window = { completion = { border = "shadow" }, documentation = { border = "shadow" } },
			})

			cmp.setup.cmdline(
				":",
				{ mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = "cmdline" } }) }
			)
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
		keys = { "<leader>", "c", "v", "g", "<tab>" },
		config = function()
			local which_key = require("which-key")
			which_key.setup({ window = { border = "shadow", position = "bottom" }, layout = { align = "center" } })
			which_key.register({ ["<leader>l"] = { name = "+LSP" }, ["<leader>f"] = { name = "+Telescope" } })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "CursorMoved",
		main = "ibl",
		opts = { scope = { enabled = false }, indent = { highlight = "LineNr" } },
	},
	{
		"folke/flash.nvim",
		opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = {"n", "x", "o" }, function() require("flash").jump() end,desc = "Flash" },
            { "S",     mode = {"n", "x", "o" }, function() require("flash").treesitter() end,desc ="Flash Treesitter" },
            { "r",     mode = "o",          function() require("flash").remote() end,desc ="Remote Flash" },
            { "<a-s>", mode = {"n", "o", "x" }, function() require("flash").treesitter_search() end,desc ="Treesitter Search" },
            { "<a-c>", mode = { "n" },      function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end, desc ="Flash Current Word" },
        },
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
