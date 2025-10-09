set formatprg=stylua\ --stdin-filepath\ %
set iskeyword-=-

if has("nvim")
    lua vim.treesitter.stop()
endif

