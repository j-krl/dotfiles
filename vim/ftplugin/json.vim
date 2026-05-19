if executable("jq")
	setlocal formatprg=prettier\ --stdin-filepath\ %
endif
