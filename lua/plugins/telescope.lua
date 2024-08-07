return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				buffers = {
					sort_mru = true,
				},
			},
		})
		telescope.load_extension("live_grep_args")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
	end,
}
