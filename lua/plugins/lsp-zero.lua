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
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					pyright = function()
						require("lspconfig").pyright.setup({
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
		end,
	},
}
