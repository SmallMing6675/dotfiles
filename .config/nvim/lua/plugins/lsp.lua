return {

	-- Format on save
	{
		"sbdchd/neoformat",
		lazy = false,
		config = function()
			vim.cmd([[augroup fmt
				  autocmd!
				  autocmd BufWritePre * Neoformat
				  augroup END]])
		end,
	},

	-- LSP Config
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig", "neovim/nvim-lspconfig" },
		lazy = false,
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "rust_analyzer" }, -- Replace with the lanuage servers you want to install
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end,
	},

	-- Code auto completion
	{

		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		lazy = false,

		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
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
					{ name = "codeium" },
				}, {
					{ name = "buffer" },
				}),
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
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
}
