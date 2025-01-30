return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({})
		vim.keymap.set("n", "<leader>r", ":Gitsigns reset_hunk<CR>", {})
		vim.keymap.set("n", "]c", function()
			gitsigns.nav_hunk("next")
		end)
		vim.keymap.set("n", "[c", function()
			gitsigns.nav_hunk("prev")
		end)
	end,
}
