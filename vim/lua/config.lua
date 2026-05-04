vim.pack.add({
	"https://github.com/airblade/vim-rooter",
	"https://github.com/selimacerbas/live-server.nvim",
	"https://github.com/selimacerbas/markdown-preview.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/jeetsukumaran/vim-indentwise",
	"https://github.com/justinmk/vim-dirvish",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/ludovicchabant/vim-gutentags",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/unblevable/quick-scope",
	-- AI
	"https://github.com/github/copilot.vim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/olimorris/codecompanion.nvim",
	-- Treesitter dependent
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/lewis6991/ts-install.nvim",
	"https://github.com/Wansmer/treesj",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
})

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { current_line = true },
	signs = {
		severity = { min = vim.diagnostic.severity.ERROR },
	},
})
vim.lsp.log.set_level(vim.log.levels.OFF)

vim.keymap.set("n", "<C-K>", vim.diagnostic.open_float)
vim.keymap.set("n", "gL", function()
	vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)

local lsps = {
	"basedpyright",
	"bashls",
	"clangd",
	"emmet_language_server",
	"gopls",
	"jsonnet_ls",
	"lua_ls",
	"ruff",
	"sqlls",
	"terraformls",
	-- "tofu_ls",
	"ts_ls",
	"vimls",
	"yamlls",
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
	elseif lsp == "tofu_ls" or lsp == "terraformls" then
		setup = {
			filetypes = { "terraform", "opentofu", "opentofu-vars" },
			settings = {
				ignoreSingleFileWarning = true,
			},
		}
	end
	vim.lsp.config(lsp, setup)
	vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		client.server_capabilities.semanticTokensProvider = false
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end

		-- TODO: DRY list functions
		local function lsp_on_list(options)
			local title = "LSP"
			if options.context.method == "textDocument/references" then
				title = "LSP References: " .. vim.fn.expand("<cword>")
			elseif options.context.method == "workspace/symbol" then
				title = "LSP Workspace Symbols: " .. options.context.params.query
			end
			vim.fn.setqflist({}, " ", {
				items = options.items,
				-- nr = "$",
				title = title,
			})
			vim.cmd.normal("mG")
			vim.cmd.cwindow()
			vim.cmd.cfirst()
			vim.cmd("norm zz")
		end

		local function lsp_on_loc_list(options)
			local title = "LSP"
			if options.context.method == "textDocument/references" then
				title = "LSP References: " .. vim.fn.expand("<cword>")
			elseif options.context.method == "workspace/symbol" then
				title = "LSP Workspace Symbols: " .. options.context.params.query
			end
			vim.fn.setloclist(0, {}, " ", {
				items = options.items,
				-- nr = "$",
				title = title,
			})
			vim.cmd.normal("mG")
			vim.cmd.lwindow()
			vim.cmd.lfirst()
			vim.cmd("norm zz")
		end

		vim.keymap.set("n", "gry", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "grs", function()
			vim.lsp.buf.workspace_symbol(nil, { on_list = lsp_on_list })
		end)
		vim.keymap.set("n", "grS", function()
			vim.lsp.buf.workspace_symbol(vim.fn.expand("<cword>"), { on_list = lsp_on_list })
		end)
		vim.keymap.set("n", "grr", function()
			vim.lsp.buf.references(nil, { on_list = lsp_on_list })
		end)
		vim.keymap.set("n", "gls", function()
			vim.lsp.buf.workspace_symbol(nil, { on_list = lsp_on_loc_list })
		end)
		vim.keymap.set("n", "glS", function()
			vim.lsp.buf.workspace_symbol(vim.fn.expand("<cword>"), { on_list = lsp_on_loc_list })
		end)
		vim.keymap.set("n", "glr", function()
			vim.lsp.buf.references({ include_declaration = false }, { on_list = lsp_on_loc_list })
		end)
	end,
})

require("ts-install").setup({
	ensure_install = {
		"bash",
		"c",
		"css",
		"go",
		"html",
		"htmldjango",
		"javascript",
		"jinja",
		"json",
		"jsonnet",
		"lua",
		"markdown",
		"python",
		"query",
		"scss",
		"svelte",
		"terraform",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
})

local fzf_lua = require("fzf-lua")

fzf_lua.setup({
	winopts = {
		split = "belowright new|resize 20",
		preview = {
			hidden = true,
		},
	},
})

fzf_lua.cd_parent = function()
	require("fzf-lua").fzf_exec("fd --type d --max-depth 1 . ..", {
		prompt = "cd_parent> ",
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					vim.fn.chdir(selected[1])
					vim.notify("cwd: " .. selected[1])
					vim.cmd("Explore")
				end
			end,
		},
	})
end

require("nvim-surround").setup()

require("markdown_preview").setup()

require("treesj").setup({ use_default_keymaps = false })

require("codecompanion").setup({
	interactions = {
		chat = {
			keymaps = {
				options = {
					modes = { n = "gH" },
				},
				clear = {
					modes = { n = "gq" },
				},
				close = {
					modes = { n = "gQ" },
				},
				stop = {
					modes = { n = "<esc>" },
				},
				next_header = {
					modes = { n = "]." },
				},
				previous_header = {
					modes = { n = "[." },
				},
				next_chat = {
					modes = { n = "gN" },
				},
				previous_chat = {
					modes = { n = "gP" },
				},
			},
		},
	},
	display = {
		chat = {
			show_header_separator = true,
			auto_scroll = true,
			opts = {
				completion_provider = "default",
			},
			window = {
				height = 0.5,
				sticky = true,
				layout = "horizontal",
			},
		},
	},
})
