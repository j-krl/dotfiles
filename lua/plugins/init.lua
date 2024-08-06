return {
	{ "justinmk/vim-sneak" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = { numbers = "buffer_id" },
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "⎸" }, -- default char is bugged on iTerm2
		},
	},
	{
		"echasnovski/mini.statusline",
		version = "*",
		config = function()
			require("mini.statusline").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
