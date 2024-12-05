return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				delay = 0,
				error_sign = false,
				style = {
					vim.api.nvim_get_hl(0, { name = "LineNr" }),
				},
			},
			indent = { enable = true },
		})
	end,
}
