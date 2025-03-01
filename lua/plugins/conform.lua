return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				sh = { "beautysh" },
				terraform = { "terraform_fmt" },
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				markdown = { "prettier" },
				json = { "prettier" },
				scss = { "prettier" },
				yaml = { "prettier" },
			},
		})
		vim.keymap.set("n", "<F3>", conform.format, { desc = "conform.format()" })
	end,
}
