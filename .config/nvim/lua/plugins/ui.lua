return {
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
				dashboard.button("SPC C F", " Open Config"),
				dashboard.button("SPC X", "󰗼 Exit"),
			}

			dashboard.section.header.opts.hl = "Type"
			dashboard.section.buttons.opts.spacing = 1
			for _, button in ipairs(dashboard.section.buttons.val) do
				-- button.opts.hl = "CursorLineNr"
				-- button.opts.hl_shortcut = "CursorLineNr"
				button.opts.width = 40
			end
			dashboard.opts.layout = {
				{ type = "padding", val = 10 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
			}
			return dashboard
		end,
		config = function(_, dashboard)
			-- close lazy and re-open when the dashboard is ready,
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
					Black,
				})
			end
			require("alpha").setup(dashboard.opts)
		end,
	},

	-- Nordic colorscheme, Swap this with your own colorscheme
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load({
				leap = {
					-- Dims the backdrop when using leap.
					dim_backdrop = true,
				},
			})
			vim.cmd.colorscheme("nordic")
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
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
					lualine_y = { "progress" },

					lualine_z = { "location" },
				},
				options = {
					theme = "nordic", -- Replace this with your own theme
					globalstatus = true,
					component_separators = { left = " ", right = " " },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "alpha" },
						winbar = { "alpha" },
						tabline = { "alpha" },
					},
				},
				tabline = {
					lualine_b = {
						{
							"buffers",
							buffers_color = {
								-- Same values as the general color option can be used here.
								active = "lualine_a_normal", -- Color for active buffer.
								inactive = "lualine_b_normal", -- Color for inactive buffer.
							},
						},
					},
					lualine_a = {},
					lualine_c = {},
					lualine_x = {},
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
				extensions = { "fzf", "lazy", "neo-tree" },
			})
		end,
	},

	-- Indent lines
	{ "lukas-reineke/indent-blankline.nvim" },

	-- Key hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gs"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
			layout = {
				spacing = 0,
				align = "center",
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
		config = function()
			require("toggleterm").setup({
				shell = "fish", -- Replace with your own shell
				size = 25,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				-- Set any options as needed
			})

			local t = {}
			-- Syntax: t[keys] = {function, {function arguments}}
			t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
			t["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
			t["<C-A-k>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
			t["<C-A-j>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
			t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
			t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
			t["zt"] = { "zt", { "250" } }
			t["zz"] = { "zz", { "250" } }
			t["zb"] = { "zb", { "250" } }

			require("neoscroll.config").set_mappings(t)
		end,
	},
}
