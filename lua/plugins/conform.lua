return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				sh = { "beautysh" },
				lua = { "stylua" },
				python = { "black" },
				typescript = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				markdown = { "prettierd" },
				json = { "prettierd" },
				scss = { "prettierd" },
				yaml = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
			},
		})
		vim.keymap.set("n", "<F3>", function()
			conform.format({ opts = { timeout_ms = 500 } })
		end, { desc = "conform.format()" })
	end,
}
