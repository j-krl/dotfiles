return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		oil = require("oil")
		oil.setup()
		vim.keymap.set("n", "<leader>e", oil.open, { desc = "Open parent directory" })
	end,
}
