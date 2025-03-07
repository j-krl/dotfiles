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
local colodark = "sorbet"
local cololight = "lunaperche"

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
-- vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- undercurl
-- vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- undercurl

-- MAPPINGS
vim.g.mapleader = " "

vim.keymap.set("n", "-", ":Explore<CR>")
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":cfirst<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":clast<CR>", { silent = true })
vim.keymap.set("n", "]l", ":lnext<CR>", { silent = true })
vim.keymap.set("n", "[l", ":lprev<CR>", { silent = true })
vim.keymap.set("n", "]L", ":lfirst<CR>", { silent = true })
vim.keymap.set("n", "[L", ":llast<CR>", { silent = true })
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
vim.keymap.set("n", "yod", string.format(":colo %s | set background=dark<CR>", colodark))
vim.keymap.set("n", "yol", string.format(":colo %s | set background=light<CR>", cololight))

vim.wo.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldminlines = 4
vim.opt.foldlevelstart = 99

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})

vim.cmd.colorscheme(colodark)
