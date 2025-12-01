if executable("stylua")
	setlocal formatprg=stylua\ --stdin-filepath\ %\ -
endif
set iskeyword-=-

