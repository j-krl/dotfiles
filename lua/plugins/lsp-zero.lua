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
					-- "jedi_language_server",
					"eslint",
					"ts_ls",
					"emmet_language_server",
					"bashls",
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					-- marksman = function()
					-- 	require("lspconfig").marksman.setup({
					-- 		on_attach = function(client)
					-- 			client.server_capabilities.completionProvider = false
					-- 		end,
					-- 	})
					-- end,
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
			-- This is all to deal with the fact that neovim shows hints as diagnostics
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
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_next({
					severity = { min = vim.diagnostic.severity.WARN },
				})
			end, { desc = "Next warning or error" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev({
					severity = { min = vim.diagnostic.severity.WARN },
				})
			end, { desc = "Previous warning or error" })
			vim.keymap.set("n", "]D", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "[D", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
		end,
	},
}
