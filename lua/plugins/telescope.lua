return {
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
				-- vimgrep_arguments = {
				-- 	-- All default args without smart-case
				-- 	"rg",
				-- 	"--color=never",
				-- 	"--no-heading",
				-- 	"--with-filename",
				-- 	"--line-number",
				-- 	"--column",
				-- },
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
					ignore = vim.list_extend(builtin_schemes, {
						"ayu",
						"ayu-light",
						"ayu-dark",
						"solarized-osaka-night",
						"solarized-osaka-day",
						"solarized-osaka-moon",
						"solarized-osaka-storm",
						"OceanicNextLight",
						"carbonfox",
						"dawnfox",
						"dayfox",
						"duskfox",
						"nordfox",
						"terafox",
						"bluloco-light",
						"bluloco",
						"monokai_soda",
						"monokai_ristretto",
						"monokai_pro",
						"catppuccin",
						"catppuccin-frappe",
						"catppuccin-mocha",
						"catppuccin-latte",
						"kanagawa",
						"kanagawa-lotus",
						"kanagawa-wave",
						-- "kanagawa-dragon",
						"tokyonight",
						"tokyonight-day",
						"tokyonight-storm",
						"tokyonight-night",
						"rose-pine-dawn",
						"rose-pine-main",
						"rose-pine",
					}),
				},
				-- themes = {
				-- 	enable_live_preview = true,
				-- },
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
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				find_command = { "fd", "--type", "f", "--color", "never", "--no-ignore-vcs" },
			})
		end, {})
		vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fp", builtin.builtin, {})
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fc", ":Telescope themes<CR>", { silent = true })
		vim.keymap.set("n", "<leader>fs", function()
			builtin.lsp_dynamic_workspace_symbols({ ignore_symbols = { "variable" } })
		end, {})
	end,
}
