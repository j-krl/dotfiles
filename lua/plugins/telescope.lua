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
		local sorters = require("telescope.sorters")
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					".git",
					"node_modules",
					"venv",
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
				},
				lsp_dynamic_workspace_symbols = {
					-- https://github.com/nvim-telescope/telescope.nvim/issues/2104
					sorter = sorters.get_fzy_sorter(),
				},
			},
		})
		telescope.load_extension("live_grep_args")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				find_command = { "fd", "--type", "f", "--color", "never", "--no-ignore-vcs" },
			})
		end, {})
		vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fc", function()
			builtin.colorscheme({ enable_preview = true })
		end, {})
		vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
	end,
}
