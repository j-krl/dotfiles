return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>b", ":G blame<CR>", { desc = "G blame" })
		vim.api.nvim_create_user_command("GV", function(opts)
			vim.cmd("vertical Git " .. opts.args)
		end, { nargs = "*" })
		vim.api.nvim_create_user_command("GT", function(opts)
			vim.cmd("tab Git " .. opts.args)
		end, { nargs = "*" })
	end,
}
