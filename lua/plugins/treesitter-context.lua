return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("treesitter-context").setup({
			mode = "topline",
			multiline_threshold = 1,
			max_lines = 3,
			trim_scope = "inned",
		})
	end,
}
