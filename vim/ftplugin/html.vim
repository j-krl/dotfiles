if executable("prettier") &&  &ft != "markdown"
	setlocal formatprg=prettier\ --stdin-filepath\ %
endif
