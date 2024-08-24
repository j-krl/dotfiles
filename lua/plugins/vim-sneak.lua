return {
	"justinmk/vim-sneak",
	config = function()
		vim.keymap.set("", "s", "<Plug>SneakLabel_s")
		vim.keymap.set("", "S", "<Plug>SneakLabel_S")
		vim.keymap.set("", "f", "<Plug>Sneak_f")
		vim.keymap.set("", "F", "<Plug>Sneak_F")
		vim.keymap.set("", "t", "<Plug>Sneak_t")
		vim.keymap.set("", "T", "<Plug>Sneak_T")
	end,
}
