return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local treesj = require("treesj")
		treesj.setup({
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>st", treesj.toggle)
		vim.keymap.set("n", "<leader>ss", treesj.split)
		vim.keymap.set("n", "<leader>sj", treesj.join)
	end,
}
