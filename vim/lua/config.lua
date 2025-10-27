local lsps = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"gopls",
	"clangd",
	"sqlls",
	"emmet_language_server",
	"terraformls",
	-- "tofu_ls",
	"vimls",
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

		local function symbol_on_list(options)
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

		vim.keymap.set("n", "gry", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "grs", function()
			vim.lsp.buf.workspace_symbol(nil, { on_list = symbol_on_list })
		end)
		vim.keymap.set("n", "grS", function()
			vim.lsp.buf.workspace_symbol(vim.fn.expand("<cword>"), { on_list = symbol_on_list })
		end)
		vim.keymap.set("n", "grr", function()
			vim.lsp.buf.references({ include_declaration = false }, { on_list = symbol_on_list })
		end)
	end,
})

require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"bash",
		"c",
		"css",
		"go",
		"html",
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
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	textobjects = {
		enable = true,
		select = {
			enable = true,
			-- lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["a?"] = "@conditional.outer",
				["i?"] = "@conditional.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["]/"] = "@conditional.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
				["]?"] = "@conditional.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[/"] = "@conditional.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
				["[?"] = "@conditional.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>tta"] = "@parameter.inner",
				["<leader>ttf"] = "@function.outer",
				["<leader>tt/"] = "@conditional.outer",
			},
			swap_previous = {
				["<leader>ttA"] = "@parameter.inner",
				["<leader>ttF"] = "@function.outer",
				["<leader>tt?"] = "@conditional.outer",
			},
		},
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["<leader>tk"] = "@function.outer",
				["<leader>tK"] = "@class.outer",
			},
		},
	},
})

require("CopilotChat").setup({
	mappings = {
		complete = { insert = "<S-tab>" },
		submit_prompt = { insert = "<C-y>" },
		accept_diff = { normal = "yd", insert = false },
		show_diff = { full_diff = true },
		reset = { normal = "grR", insert = false },
	},
	window = { width = 0.33 },
})

require("treesj").setup({
	use_default_keymaps = false,
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 2,
	trim_scope = "inner",
})

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = {
		current_line = true,
	},
	signs = {
		severity = { min = vim.diagnostic.severity.ERROR },
	},
})
vim.lsp.log.set_level(vim.log.levels.OFF)

vim.keymap.set("n", "<leader>ts", "<cmd>TSJToggle<cr>")
vim.keymap.set({ "n", "v" }, "<leader>.", ":<C-U>CopilotChatToggle<cr><C-W>=", { silent = true })
-- vim.keymap.set({ "n", "v" }, "<leader>,", ":<C-U>CopilotChatClose<cr><C-W>=", { silent = true })
vim.keymap.set("n", "]D", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "[D", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "<C-K>", vim.diagnostic.open_float)
vim.keymap.set("n", "gL", function()
	vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)
