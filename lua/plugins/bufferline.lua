return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "buffer_id",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diag, context)
					return level:match("error") and "" or level:match("warning") and "" or ""
				end,
			},
		})
	end,
}
