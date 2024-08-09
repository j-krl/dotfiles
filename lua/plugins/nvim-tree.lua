return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			view = {
				relativenumber = true,
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
	end,
}
