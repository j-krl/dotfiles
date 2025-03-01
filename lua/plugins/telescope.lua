return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		config = function()
			local telescope = require("telescope")
			local sorters = require("telescope.sorters")
			local actions = require("telescope.actions")
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
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--hidden",
					},
				},
				pickers = {
					lsp_dynamic_workspace_symbols = {
						-- https://github.com/nvim-telescope/telescope.nvim/issues/2104
						sorter = sorters.get_fzy_sorter(),
					},
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true,
						mappings = {
							i = {
								["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							},
						},
					},
				},
			})
			telescope.load_extension("live_grep_args")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					hidden = true,
					find_command = { "fd", "--type", "f", "--color", "never", "--no-ignore-vcs" },
				})
			end, { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", telescope.extensions.live_grep_args.live_grep_args, { desc = "ripgrep" })
			vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "Oldfiles" })
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
