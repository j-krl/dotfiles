return {
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "onsails/lspkind.nvim" },
	{ "hrsh7th/cmp-buffer" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Esc>"] = cmp.mapping.abort(),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
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
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol",
						before = function(entry, vim_item)
							if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
								vim_item.menu = entry.completion_item.detail
							else
								vim_item.menu = ({
									nvim_lsp = "[LSP]",
									luasnip = "[Snippet]",
									buffer = "[Buffer]",
									path = "[Path]",
									nvim_lua = "[Lua]",
								})[entry.source.name]
							end
							return vim_item
						end,
					}),
				},
			})
		end,
	},
}
