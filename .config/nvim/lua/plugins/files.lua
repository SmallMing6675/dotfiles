return {
	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
						["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
						["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
						["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["am"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["im"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["<leader>mf"] = { query = "@call.outer", desc = "Next function call start" },
						["<leader>mm"] = { query = "@function.outer", desc = "Next method/function def start" },
						["<leader>mc"] = { query = "@class.outer", desc = "Next class start" },
						["<leader>mi"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["<leader>ml"] = { query = "@loop.outer", desc = "Next loop start" },

						["<leader>ms"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["<leader>mz"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["<leader>mF"] = { query = "@call.outer", desc = "Next function call end" },
						["<leader>mM"] = { query = "@function.outer", desc = "Next method/function def end" },
						["<leader>mC"] = { query = "@class.outer", desc = "Next class end" },
						["<leader>mI"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["<leader>mL"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["<leader>pf"] = { query = "@call.outer", desc = "Prev function call start" },
						["<leader>pm"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["<leader>pc"] = { query = "@class.outer", desc = "Prev class start" },
						["<leader>pi"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["<leader>pl"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["<leader>pF"] = { query = "@call.outer", desc = "Prev function call end" },
						["<leader>pM"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["<leader>pC"] = { query = "@class.outer", desc = "Prev class end" },
						["<leader>pI"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["<leader>pL"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
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
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
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
