return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				sh = { "beautysh" },
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
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
			format_on_save = {
				timeout_ms = 1000,
			},
		})
		vim.keymap.set("n", "<F3>", function()
			conform.format({ opts = { timeout_ms = 1000 } })
		end, { desc = "conform.format()" })
	end,
}
