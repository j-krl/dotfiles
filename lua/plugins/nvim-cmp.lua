return {
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "onsails/lspkind.nvim" },
	{ "hrsh7th/cmp-buffer" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip = require("luasnip")
			luasnip.filetype_extend("typescript", { "tsdoc" })
			luasnip.filetype_extend("typescriptreact", { "tsdoc" })
			luasnip.filetype_extend("javascript", { "jsdoc" })
			luasnip.filetype_extend("javascriptreact", { "jsdoc" })
			luasnip.filetype_extend("python", { "pydoc" })
			luasnip.filetype_extend("lua", { "luadoc" })
			luasnip.filetype_extend("sh", { "shelldoc" })

			vim.keymap.set({ "i" }, "<C-K>", function()
				luasnip.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				luasnip.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-H>", function()
				luasnip.jump(-1)
			end, { silent = true })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					autocomplete = false,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "luasnip" },
					{ name = "cmp-nvim-lsp-signature-help" },
					{ name = "path" },
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
					}),
				},
			})
		end,
	},
}
