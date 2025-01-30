return {
	{},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
			-- TODO: Ignoring builtins will be native to Telescope in future release,
			-- 			 so delete this on next Telescope update
			{ "andrew-george/telescope-themes" },
		},
		config = function()
			local telescope = require("telescope")
			local sorters = require("telescope.sorters")
			local actions = require("telescope.actions")
			local builtin_schemes = require("telescope._extensions.themes").builtin_schemes
			telescope.setup({
				defaults = {
					mappings = {
						n = {
							["<C-Q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
						i = {
							["<C-e>"] = { "<esc>", type = "command" },
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					buffers = {
						sort_mru = true,
					},
					lsp_dynamic_workspace_symbols = {
						-- https://github.com/nvim-telescope/telescope.nvim/issues/2104
						sorter = sorters.get_fzy_sorter(),
					},
				},
				extensions = {
					themes = {
						enable_live_preview = true,
						enable_previewer = true,
						ignore = vim.list_extend(builtin_schemes, {
							"monokai_soda",
							"monokai_ristretto",
							"monokai_pro",
						}),
					},
					live_grep_args = {
						mappings = {
							i = {
								["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							},
						},
					},
				},
			})
			telescope.load_extension("live_grep_args")
			telescope.load_extension("themes")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					hidden = true,
					find_command = { "fd", "--type", "f", "--color", "never", "--no-ignore-vcs" },
				})
			end, { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", telescope.extensions.live_grep_args.live_grep_args, { desc = "ripgrep" })
			vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "Oldfiles" })
			-- vim.keymap.set("n", "<leader>c", ":Telescope themes<CR>", { desc = "Colorschemes", silent = true })
			vim.keymap.set("n", "<leader>s", function()
				builtin.lsp_dynamic_workspace_symbols({
					ignore_symbols = { "variable" },
					path_display = { "smart" },
				})
			end, {
				desc = "LSP Workspace Symbols",
			})
		end,
	},
}
