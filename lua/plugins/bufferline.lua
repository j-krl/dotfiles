return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				numbers = "both",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diag, context)
					return level:match("error") and "" or level:match("warning") and "" or ""
				end,
			},
		})
		vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>")
		-- vim.keymap.set("n", "<leader>bs", ":BufferLinePick<CR>")
		-- vim.keymap.set("n", "]z", ":BufferLineMoveNext<CR>", { silent = true })
		-- vim.keymap.set("n", "[z", ":BufferLineMovePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader>0", ":BufferLineGoToBuffer -1<CR>", { silent = true })
		vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { silent = true })
		vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { silent = true })
		vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { silent = true })
		vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { silent = true })
		vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { silent = true })
		vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { silent = true })
		vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { silent = true })
		vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { silent = true })
		vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { silent = true })
	end,
}
