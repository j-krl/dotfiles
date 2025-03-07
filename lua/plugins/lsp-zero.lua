return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{
		"VonHeikemen/lsp-zero.nvim",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({
					buffer = bufnr,
					exclude = { "<F3>", "gi" },
					preserve_mappings = false,
				})
			end)
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"pylsp",
					"marksman",
					"eslint",
					"ts_ls",
					"emmet_language_server",
					"bashls",
					"lua_ls",
				},
				handlers = {
					pylsp = function()
						require("lspconfig").pylsp.setup({
							settings = {
								pylsp = {
									-- Only use pylsp for completions (jedi under the hood)
									plugins = {
										pyflakes = { enabled = false },
										mccabe = { enabled = false },
										pycodestyle = { enabled = false },
										pydocstyle = { enabled = false },
										autopep8 = { enabled = false },
									},
								},
							},
						})
					end,
					bashls = function()
						require("lspconfig").bashls.setup({
							filetypes = { "sh", "zsh" },
						})
					end,
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								diagnostics = {
									globals = {
										"vim",
									},
								},
							},
						})
					end,
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
			vim.diagnostic.config({
				signs = {
					severity = { min = vim.diagnostic.severity.WARN },
				},
				virtual_text = false,
			})
			vim.keymap.set("n", "gL", function()
				---@diagnostic disable-next-line: assign-type-mismatch
				vim.diagnostic.setloclist({ severity = { min = vim.diagnostic.severity.WARN } })
			end, { desc = "Go to diagnostics" })
		end,
	},
}
