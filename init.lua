local vimrc = vim.fn.stdpath("config") .. "/.vimrc"
vim.cmd.source(vimrc)

require("paq")({
	"savq/paq-nvim",
	-- vimscript
	"tpope/vim-sleuth",
	"unblevable/quick-scope",
	"tpope/vim-surround",
	"tpope/vim-obsession",
	"mbbill/undotree",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"tpope/vim-fugitive",
	-- lua
	"neovim/nvim-lspconfig",
	"stevearc/conform.nvim",
})

-- LSP
local lspconfig = require("lspconfig")
local lsps = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"emmet_language_server",
}
-- Set up all LSPs that we want
for _, lsp in pairs(lsps) do
	local setup = {}
	if lsp == "basedpyright" then
		setup = {
			settings = {
				[lsp] = {
					analysis = {
						diagnosticMode = "workspace",
						typeCheckingMode = "off",
						-- So I can use basedpyright's import code action
						diagnosticSeverityOverrides = {
							reportMissingImports = "error",
							reportUndefinedVariable = "error",
							reportCallIssue = "error",
						},
					},
				},
			},
		}
	end
	lspconfig[lsp].setup(setup)
end
-- LSP only mappings
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
	end,
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		sh = { "beautysh" },
		terraform = { "terraform_fmt" },
		lua = { "stylua" },
		-- "ruff_fix" removes unused imports
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
	format_after_save = {}, -- TODO: remove
})

-- Options
vim.diagnostic.config({
	signs = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = false,
})

-- Mappings
vim.keymap.set("n", "<F3>", require("conform").format)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
