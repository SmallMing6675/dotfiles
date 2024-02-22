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
				{ type = "padding", val = 2 },
				dashboard.section.footer,
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

			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Lazy-loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
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
			vim.cmd(":hi CursorLine guifg=none guibg=none")
			vim.cmd(":hi WinSeparator guifg=#242933 ")
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
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				scope = {
					enabled = true,
					highlight = { "keyword", "Label" },
				},
			})
		end,
	},

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
				["<leader>d"] = { name = "+debug" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>w"] = { name = "+windows" },
				["<leader>l"] = { name = "+LSP" },
				["<leader>m"] = { name = "+LSP Goto Next" },
				["<leader>p"] = { name = "+LSP Goto Previous" },
				["<leader>t"] = { name = "+Terminal" },
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
			require("neoscroll").setup()

			local t = {}
			t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
			t["<C-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
			t["<C-A-k>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
			t["<C-A-j>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
			require("neoscroll.config").set_mappings(t)
		end,
	},
	{
		"folke/noice.nvim",
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
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
}
