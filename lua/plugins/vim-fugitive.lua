return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", {})
		vim.keymap.set("n", "<leader>gb", ":G blame<CR>", {})
	end,
}
