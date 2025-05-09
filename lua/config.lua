---------
-- LSP --
---------

local lspconfig = require("lspconfig")
local lsps = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"sqlls",
	"emmet_language_server",
	"terraformls",
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
	elseif lsp == "sqlls" then
		setup = {
			root_dir = "~/.config/sql-language-server",
		}
	end
	lspconfig[lsp].setup(setup)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end
		local function symbol_on_list(options)
			-- Improve the default qflist behaviour in `workspace_symbol`
			vim.fn.setqflist({}, " ", options)
			vim.cmd.normal("mG")
			vim.cmd.cfirst()
			vim.cmd.cclose()
		end
		vim.keymap.set("n", "gry", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "grs", function()
			vim.lsp.buf.workspace_symbol(nil, { on_list = symbol_on_list })
		end)
	end,
})

----------------
-- Formatting --
----------------

require("conform").setup({
	formatters_by_ft = {
		sh = { "beautysh" },
		terraform = { "terraform_fmt" },
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
		sql = { "sql_formatter" },
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

--------
-- AI --
--------

vim.g.SUPERMAVEN_DISABLED = true -- https://github.com/supermaven-inc/supermaven-nvim/pull/101
require("supermaven-nvim").setup({
	condition = function()
		return vim.g.SUPERMAVEN_DISABLED
	end,
})

------------------------
-- Mappings & options --
------------------------

-- Options
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
	},
})

-- Mappings
vim.keymap.set("n", "<F3>", require("conform").format)
vim.keymap.set("n", "<leader>m", "<cmd>SupermavenToggle<cr>")
vim.keymap.set("n", "]D", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "[D", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "<A-k>", vim.diagnostic.open_float)
vim.keymap.set("n", "<A-K>", function()
	vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)
