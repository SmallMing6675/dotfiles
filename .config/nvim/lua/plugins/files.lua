return {
	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
		},

		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
			vim.cmd("silent TSUpdate")
		end,
	},

	-- Telescope for fuzzy finding files
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },

		opts = function(_, opts)
			local function flash(prompt_bufnr)
				require("flash").jump({
					pattern = "^",
					label = { after = { 0, 0 } },
					search = {
						mode = "search",
						exclude = {
							function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
							end,
						},
					},
					action = function(match)
						local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						picker:set_selection(match.pos[1] - 1)
					end,
				})
			end
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				mappings = {
					n = { s = flash },
					i = { ["<c-s>"] = flash },
				},
			})
		end,
		tag = "0.1.5",
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
				},
			})

			local background = vim.fn.synIDattr(vim.fn.hlID("TelescopeNormal"), "bg")
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = background, fg = background })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = background, fg = background })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = background, fg = background })

			require("telescope").load_extension("ui-select")
		end,
	},

	-- Aerial for selecting symbols within a file
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
		end,
	},

	{ "mbbill/undotree" },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"hrsh7th/cmp-nvim-lsp",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		lazy = false,
		config = function()
			require("dapui").setup({})

			local background = vim.fn.synIDattr(vim.fn.hlID("TelescopeNormal"), "bg")
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = background, fg = background })

			require("nvim-dap-virtual-text").setup()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},

				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
			})
		end,
	},
}
