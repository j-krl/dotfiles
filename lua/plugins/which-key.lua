return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- triggers = {
		-- 	{ "<auto>", mode = "" },
		-- },
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show()
				-- require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
