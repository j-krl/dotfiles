if executable("stylua")
	setlocal formatprg=stylua\ --stdin-filepath\ %\ -
endif
set iskeyword-=-

if has("nvim")
	lua vim.treesitter.stop()
endif

