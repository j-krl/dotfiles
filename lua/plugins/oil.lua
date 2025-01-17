return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		oil = require("oil")
		oil.setup()
		vim.keymap.set("n", "<leader>eo", oil.open, { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>ed", oil.close, { desc = "Close oil" })
		vim.keymap.set("n", "<leader>et", oil.toggle_float, { desc = "Toggle parent directory in floating window" })
		-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
