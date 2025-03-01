return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
			},
			signs_staged_enable = false,
		})
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
