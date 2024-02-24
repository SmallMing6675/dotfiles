------------------------------------------------------
-- My Simple Neovim configuration (Mostly stolen)   --
-- designed as a starting point for your own config --
-- Feel free the copy and modify the config!        --
------------------------------------------------------

vim.loader.enable()

------------ Configuration for neovim itself -------------
vim.g.mapleader = " "
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.lazyredraw = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

vim.o.wrap = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 0
vim.o.fillchars = "eob: "

vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")

---------- keymaps ----------
local map = vim.keymap.set

map("n", "<leader>n", ":ene <BAR> startinsert <CR>", { desc = "New File" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Term" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "j", "v:count == 1 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v", "i" }, "<up>", "<nop>")
map({ "n", "v", "i" }, "<down>", "<nop>")
map({ "n", "v", "i" }, "<left>", "<nop>")
map({ "n", "v", "i" }, "<right>", "<nop>")

map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Find: Files" })
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Find: Grep" })
map("n", "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find: Grep Within Current Buffer" })
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Find: Buffers" })
map("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Find: Recent Files" })
map("n", "<leader>fm", "<Cmd>Telescope man_pages<CR>", { desc = "Find: Man Pages" })

map("n", "<Leader>w", "<c-w>", { desc = "Window Options" })
map("n", "<Leader>q", ":wq<CR>", { desc = "Save Then Exit" })
map("n", "<Leader>x", ":q<CR>", { desc = "Exit" })
map("n", "H", "_", { desc = "Start of the line" })
map("n", "L", "$", { desc = "End of the line" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "Open Vertical Split" })
map("n", "<leader>h", ":split<CR>", { desc = "Open Horizontal Split" })
map("n", "<leader>q", "<Cmd>wq<CR><CR>", { desc = "Close Buffer" })
map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })
map("n", "<C-j>", "<Cmd>bp<CR>", { desc = "Go to previous Buffer" })
map("n", "<C-k>", "<Cmd>bn<CR>", { desc = "Go to Next Buffer" })

map("n", "<A-1>", "<Cmd>LualineBuffersJump! 1<CR>", { desc = "Go to Buffer 1" })
map("n", "<A-2>", "<Cmd>LualineBuffersJump! 2<CR>", { desc = "Go to Buffer 2" })
map("n", "<A-3>", "<Cmd>LualineBuffersJump! 3<CR>", { desc = "Go to Buffer 3" })
map("n", "<A-4>", "<Cmd>LualineBuffersJump! 4<CR>", { desc = "Go to Buffer 4" })
map("n", "<A-5>", "<Cmd>LualineBuffersJump! 5<CR>", { desc = "Go to Buffer 5" })
map("n", "<A-6>", "<Cmd>LualineBuffersJump! 6<CR>", { desc = "Go to Buffer 6" })
map("n", "<A-7>", "<Cmd>LualineBuffersJump! 7<CR>", { desc = "Go to Buffer 7" })
map("n", "<A-8>", "<Cmd>LualineBuffersJump! 8<CR>", { desc = "Go to Buffer 8" })
map("n", "<A-9>", "<Cmd>LualineBuffersJump! 9<CR>", { desc = "Go to Buffer 9" })
map("n", "<A-0>", "<Cmd>LualineBuffersJump! $<CR>", { desc = "Go to Last Buffer" })

map("n", "<leader>C", "ggVG<cr>", { desc = "Select all text" })
map("n", "<leader>tb", "<Cmd>Vista!!<CR>", { desc = "Toggle TagBar" })

map("n", "=", "<cmd>horizontal resize +5<cr>", { desc = "Resize Window Up" })
map("n", "-", "<cmd>horizontal resize -5<cr>", { desc = "Resize Window Down" })
map("n", "+", "<cmd>vertical resize +5<cr>", { desc = "Resize Window Left" })
map("n", "_", "<cmd>vertical resize -5<cr>", { desc = "Resize Window Right" })

map("n", "<A-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<A-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<A-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<A-l>", "<C-w>l", { desc = "Window Right" })
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undo Tree" })

map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map("n", "<leader>lm", vim.lsp.buf.format, { desc = "LSP: Format" })
map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
map("n", "<leader>lf", vim.lsp.buf.references, { desc = "LSP: Find References" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Open Float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Goto Next Diagnostic" })

map("n", "<C-S-k>", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<C-S-j>", "<cmd>tabprevious<CR>", { desc = "Tab: Previous " })
map("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "Tab: New" })
map("n", "<leader><tab>j", "<cmd>tabnext<CR>", { desc = "Tab: Next" })
map("n", "<leader><tab>k", "<cmd>tabprevious<CR>", { desc = "Tab: Previous " })
map("n", "<leader><tab>x", "<cmd>tabclose<CR>", { desc = "Tab: Close " })

map("n", "J", "<C-d>")
map("n", "K", "<C-u>")

---------- setting plugins ----------
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

local plugins = {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Tree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = { "rust", "python", "c", "lua", "vim", "vimdoc", "query" },
			auto_install = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Telescope for fuzzy finding files
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		tag = "0.1.5",
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						follow = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						hijack_netrw = true,
					},
				},
			})
			local background = vim.fn.synIDattr(vim.fn.hlID("TelescopeNormal"), "bg")
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = background, fg = background })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = background, fg = background })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = background, fg = background })

			require("telescope").load_extension("ui-select")
		end,
	},
	{ "liuchengxu/vista.vim", keys = { "<leader>tb" }, cmd = "Vista" },
	{ "mbbill/undotree", keys = { "<leader>u" }, cmd = "UndotreeToggle" },
	-- Format on save
	{
		"sbdchd/neoformat",
		event = "BufWritePre",
		config = function()
			vim.cmd([[
            augroup fmt
              autocmd!
              autocmd BufWritePre * undojoin | Neoformat
            augroup END
           ]])

			vim.g.neoformat_c_clangformat = {
				exe = "clang-format",
				args = { "--style=Webkit" },
			}
		end,
	},
	-- LSP Config
	{
		"williamboman/mason.nvim",
		event = "BufEnter",
		dependencies = {
			"williamboman/mason-lspconfig",
			"neovim/nvim-lspconfig",
			"onsails/lspkind.nvim",
		},
		config = function()
			local default_setup = function(server)
				require("lspconfig")[server].setup({})
			end
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					default_setup,
				},
			})
		end,
	},
	{
		"yioneko/nvim-cmp",
		event = "BufEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
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
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				window = {
					completion = cmp.config.window.bordered({
						border = "none",
					}),

					documentation = cmp.config.window.bordered({
						border = "none",
					}),
				},
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = "BufEnter" },
	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				[[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
				[[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
				[[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
				[[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
				[[██   ████ ███████  ██████    ████   ██ ██      ██]],
			}
			dashboard.section.buttons.val = {
				dashboard.button("SPC N", " New File"),
				dashboard.button("SPC F R", " Recent Files"),
				dashboard.button("SPC F F", " Find File"),
				dashboard.button("SPC F G", " Find Text"),
				dashboard.button("SPC X", "󰗼 Exit"),
			}
			dashboard.section.header.opts.hl = "Function"
			dashboard.section.buttons.opts.spacing = 1
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl_shortcut = "Label"
				button.opts.width = 40
			end

			dashboard.opts.layout = {
				{ type = "padding", val = 10 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				dashboard.section.footer,
			}

			return dashboard
		end,
		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)
			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					dashboard.section.footer.val = "󱐌 Lazy-loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. math.floor(stats.startuptime * 100) / 100
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_c = {
						{
							"filename",
							symbols = {
								modified = "󱇧",
								readonly = "",
								unnamed = "󰲶",
								newfile = "",
							},
						},
					},
					lualine_x = { "filetype" },
				},
				options = {
					theme = "tokyonight", -- Replace this with your own theme
					section_separators = { left = "", right = "" },
				},
				tabline = {
					lualine_a = { "buffers" },
					lualine_y = {
						{
							"filename",
							symbols = {
								modified = "󱇧",
								readonly = "",
								unnamed = "󰲶",
								newfile = "",
							},
						},
					},
					lualine_z = { "tabs" },
				},
				extensions = { "fzf", "lazy", "neo-tree", "aerial", "fzf", "toggleterm" },
			})
		end,
	},
	-- Key hints
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", '"', "'", "`", "c", "v", "g" },
		opts = {
			defaults = {
				mode = { "n", "v" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>l"] = { name = "+LSP" },
				["<leader>t"] = { name = "+Terminal" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		opts = {
			shell = "fish", -- Replace with your own shell
			size = 25,
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = false,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
	},
	-- Flash to quickly search within a file
	{
		"folke/flash.nvim",
		opts = {},
		lazy = false,
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
            { "<a-s>", mode = {"n"}, function() require("flash").jump({pattern = vim.fn.expand("<cword>"), }) end, desc = "Flash Current Word"},
        },
	},
	{ "tpope/vim-surround", event = "InsertEnter" },
    -- stylua: ignore
    {
        {"echasnovski/mini.pairs", event = "InsertEnter", version = false, config = function() require("mini.pairs").setup() end},
        {"echasnovski/mini.animate", version = false, config = function() require("mini.animate").setup() end},
        {"echasnovski/mini.ai", event = "InsertEnter", version = false, config = function() require("mini.ai").setup() end},
        {"echasnovski/mini.comment", event = "InsertEnter", version = false, config = function() require("mini.comment").setup() end},
    },
}
require("lazy").setup({ plugins })
vim.cmd("silent TSUpdate")
