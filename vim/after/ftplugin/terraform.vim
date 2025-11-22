if executable("tofu")
	setlocal formatprg=tofu\ fmt\ -no-color\ -
endif
nnoremap <silent> <buffer> <localleader><cr> <cmd>call terraform#GoToModuleDefinition()<cr>
nnoremap <localleader>grr <cmd>grep 'source.*\=.*%:h'<cr>

