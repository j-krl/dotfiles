return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"markdown",
				"vimdoc",
				"html",
				"css",
				"typescript",
				"javascript",
				"python",
				"terraform",
			},
			auto_install = true,
			highlight = { enable = false },
		})
	end,
}
