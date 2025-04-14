local vimrc = vim.fn.stdpath("config") .. "/.vimrc"
vim.cmd.source(vimrc)

require("paq")({
	"savq/paq-nvim",
	-- vimscript
	"mbbill/undotree",
	"christoomey/vim-tmux-navigator",
	"unblevable/quick-scope",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"tpope/vim-obsession",
	"tpope/vim-fugitive",
	-- lua
	"neovim/nvim-lspconfig",
	"stevearc/conform.nvim",
})

-- LSP setup
local lspconfig = require("lspconfig")
local lsps = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"sqlls",
	"emmet_language_server",
}
for _, lsp in pairs(lsps) do
	local setup = {}
	if lsp == "basedpyright" then
		setup = {
			settings = {
				[lsp] = {
					analysis = {
						diagnosticMode = "workspace",
						typeCheckingMode = "off",
					},
				},
			},
		}
	end
	lspconfig[lsp].setup(setup)
end

-- Completions
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end
	end,
})

-- Formatting
require("conform").setup({
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
		json = { "prettier" },
		scss = { "prettier" },
		yaml = { "prettier" },
	},
	format_after_save = {}, -- TODO: remove
})

-- Options
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
	},
})

-- Mappings
vim.keymap.set("n", "<F3>", require("conform").format)
vim.keymap.set("n", "]D", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "[D", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "gL", function()
	vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)
