return {
	-- Flash to quickly search within a file
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
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

	-- Automatically create closing parens
	{
		"jiangmiao/auto-pairs",
	},

	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"codota/tabnine-nvim",
		build = "./dl_binaries.sh",
		config = function()
			require("tabnine").setup({
				disable_auto_comment = true,
				accept_keymap = "<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt", "NvimTree" },
				log_file_path = nil, -- absolute path to Tabnine log file
			})
		end,
	},
	{
		"ThePrimeagen/vim-be-good",
	},
}
