return {
	"junegunn/fzf.vim",
	dependencies = { "junegunn/fzf" },
	config = function()
		vim.keymap.set("n", "<leader>f", ":Files<CR>", { desc = "Find files" })
		vim.keymap.set("n", "<leader>g", ":RG<CR>", { desc = "ripgrep" })
	end,
}
