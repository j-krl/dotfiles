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
		vim.keymap.set("n", "]c", function()
			gitsigns.nav_hunk("next", { target = "all" })
		end)
		vim.keymap.set("n", "[c", function()
			gitsigns.nav_hunk("prev", { target = "all" })
		end)
	end,
}
