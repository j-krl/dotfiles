return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local nvim_tree = require("nvim-tree")
		nvim_tree.setup({
			view = {
				relativenumber = true,
				adaptive_size = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			diagnostics = {
				enable = true,
			},
			filters = {
				git_ignored = false,
			},
		})
		vim.keymap.set("n", "<leader>to", ":NvimTreeOpen<CR>", {})
		vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", {})
		vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", {})
		vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>", {})
	end,
}
