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
-- vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- MAPPINGS
vim.g.mapleader = " "
-- Buffers
vim.keymap.set("n", "<leader>bf", ":buffers<CR>", { desc = "List open buffers" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bc", ":%bd|Alpha|bd#<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all buffers but current" })
-- Marks
vim.keymap.set("n", "<leader>mc", ":delm! | delm A-Z<CR>", { desc = "Clear all marks" })
vim.keymap.set("n", "<leader>mf", ":marks<CR>", { desc = "Show marks" })
vim.keymap.set("n", "mq", "mQ", { desc = "mQ", silent = true })
vim.keymap.set("n", "mw", "mW", { desc = "mW", silent = true })
vim.keymap.set("n", "me", "mE", { desc = "mE", silent = true })
vim.keymap.set("n", "mr", "mR", { desc = "mR", silent = true })
vim.keymap.set("n", "mt", "mT", { desc = "mT", silent = true })
vim.keymap.set("n", "'q", "'Q", { desc = "'Q", silent = true })
vim.keymap.set("n", "'w", "'W", { desc = "'W", silent = true })
vim.keymap.set("n", "'e", "'E", { desc = "'E", silent = true })
vim.keymap.set("n", "'r", "'R", { desc = "'R", silent = true })
vim.keymap.set("n", "'t", "'T", { desc = "'T", silent = true })
-- Diagnotics
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
-- Unimpaired
-- These are mappings I like from the vim-unimpaired plugin that I've since removed
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "]B", ":bfirst<CR>", { silent = true })
vim.keymap.set("n", "[B", ":blast<CR>", { silent = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":cfirst<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":clast<CR>", { silent = true })
vim.keymap.set("n", "]l", ":lnext<CR>", { silent = true })
vim.keymap.set("n", "[l", ":lprev<CR>", { silent = true })
vim.keymap.set("n", "]L", ":lfirst<CR>", { silent = true })
vim.keymap.set("n", "[L", ":llast<CR>", { silent = true })
vim.keymap.set("n", "]t", ":tnext<CR>", { silent = true })
vim.keymap.set("n", "[t", ":tprev<CR>", { silent = true })
vim.keymap.set("n", "]T", ":tfirst<CR>", { silent = true })
vim.keymap.set("n", "[T", ":tlast<CR>", { silent = true })
vim.cmd('nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>') -- Blank line below
vim.cmd('nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>') -- Blank line above
vim.keymap.set("n", "yor", ":set rnu!<CR>", { desc = "Toggle relative numbers" })

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

vim.cmd("colorscheme gruvbox")
