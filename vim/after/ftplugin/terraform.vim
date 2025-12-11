if executable("tofu")
	setlocal formatprg=tofu\ fmt\ -no-color\ -
endif
nnoremap <silent> <buffer> <localleader><C-]> <cmd>call terraform#GoToModuleDefinition()<cr>
nnoremap <localleader>grr <cmd>grep 'source.*\=.*%:h'<cr>

