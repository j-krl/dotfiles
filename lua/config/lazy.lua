-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.loaded_netrw = 1 -- Use nvim-tree
vim.g.loaded_netrwPlugin = 1 -- Use nvim-tree
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80,88"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
-- vim.opt.scrolloff = 20
vim.opt.undofile = true
vim.opt.wildmode = "list:longest,full"
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- Mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>bd", ":%bd|e#|bd#<CR>", { desc = "Close all buffers but current" })
vim.keymap.set("n", "<leader>ln", ":set rnu!<CR>", { desc = "Toggle relativenumber" })
-- vim.keymap.set("n", "oo", "o<Esc>k")
-- vim.keymap.set("n", "OO", "O<Esc>j")
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.cmd("colorscheme onedark")
