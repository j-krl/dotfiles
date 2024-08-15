return {
	"sindrets/diffview.nvim",
	config = function()
		vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", {})
		vim.keymap.set("n", "<leader>dq", ":DiffviewClose<CR>", {})
		vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", {})
		vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", {})
	end,
}
