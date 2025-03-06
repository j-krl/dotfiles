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

-- OPTIONS
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
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.wildmode = "list:longest,full"
vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- undercurl
vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- undercurl

-- MAPPINGS
vim.g.mapleader = " "

vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":cfirst<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":clast<CR>", { silent = true })
vim.keymap.set("n", "]l", ":lnext<CR>", { silent = true })
vim.keymap.set("n", "[l", ":lprev<CR>", { silent = true })
vim.keymap.set("n", "]L", ":lfirst<CR>", { silent = true })
vim.keymap.set("n", "[L", ":llast<CR>", { silent = true })
vim.keymap.set("n", "]t", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "[t", ":tabp<CR>", { silent = true })
vim.keymap.set("n", "]T", ":tabfir<CR>", { silent = true })
vim.keymap.set("n", "[T", ":tabl<CR>", { silent = true })
vim.keymap.set("n", "<C-W>O", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<C-W>C", ":tabcl<CR>", { silent = true })
vim.cmd('nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>') -- Blank line below
vim.cmd('nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>') -- Blank line above
vim.keymap.set("n", "yor", ":set rnu!<CR>", { desc = "Toggle relative numbers" })
vim.keymap.set(
	"n",
	"yob",
	':set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>',
	{ desc = "Toggle background" }
)

vim.wo.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldminlines = 4
vim.opt.foldlevelstart = 99

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

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check evening plugin updates
	checker = { enabled = true },
})

vim.cmd("colorscheme sorbet")
