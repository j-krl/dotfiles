return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			current_line_blame = true,
		})
		vim.keymap.set("n", "<leader>S", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>r", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>p", ":Gitsigns preview_hunk_inline<CR>", { desc = "Preview hunk inline" })
		vim.keymap.set("n", "]c", function()
			gitsigns.nav_hunk("next", { target = "all" })
		end)
		vim.keymap.set("n", "[c", function()
			gitsigns.nav_hunk("prev", { target = "all" })
		end)
	end,
}
