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
					-- Let conform.nvim handle formatting
					exclude = { "<F3>" },
					preserve_mappings = false,
				})
			end)
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"pylsp",
					-- "jedi_language_server",
					"eslint",
					"tsserver",
					"emmet_language_server",
					"bashls",
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					pyright = function()
						require("lspconfig").pyright.setup({
							-- https://github.com/microsoft/pyright/discussions/5852#discussioncomment-6874502
							-- capabilities = {
							-- 	textDocument = {
							-- 		publishDiagnostics = {
							-- 			tagSupport = {
							-- 				valueSet = { 2 },
							-- 			},
							-- 		},
							-- 	},
							-- },
							settings = {
								python = {
									analysis = {
										typeCheckingMode = "off",
										autoImportCompletions = true,
										diagnosticMode = "workspace",
									},
								},
							},
						})
					end,
					pylsp = function()
						require("lspconfig").pylsp.setup({
							settings = {
								pylsp = {
									-- Only use pylsp for completions
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
					-- jedi_language_server = function()
					-- 	require("lspconfig").jedi_language_server.setup({
					-- 		init_options = {
					-- 			workspace = {
					-- 				symbols = {
					-- 					maxSymbols = 0,
					-- 				},
					-- 			},
					-- 		},
					-- 	})
					-- end,
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
				},
			})
			vim.diagnostic.config({
				signs = {
					severity = { min = vim.diagnostic.severity.WARN },
				},
				virtual_text = {
					severity = { min = vim.diagnostic.severity.WARN },
				},
			})
			vim.keymap.set("n", "gL", function()
				---@diagnostic disable-next-line: assign-type-mismatch
				vim.diagnostic.setloclist({ severity = { min = vim.diagnostic.severity.WARN } })
			end, { desc = "Go to diagnostics" })
		end,
	},
}
