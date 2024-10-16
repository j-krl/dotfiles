return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({})
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", {})
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", {})
		vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", {})
		vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", {})
		vim.keymap.set("n", "]c", function()
			gitsigns.nav_hunk("next")
		end)
		vim.keymap.set("n", "[c", function()
			gitsigns.nav_hunk("prev")
		end)
	end,
}
