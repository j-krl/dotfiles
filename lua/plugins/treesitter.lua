return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"markdown",
				"vimdoc",
				"html",
				"css",
				"typescript",
				"javascript",
				"python",
			},
			auto_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = { enable = true },
		})
		-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "indent"
		vim.wo.foldminlines = 4
		vim.opt.foldlevelstart = 99
	end,
}
