if executable("tf")
	setlocal formatprg=tf\ fmt\ -no-color\ -
endif
nnoremap <silent> <buffer> <localleader><cr> <cmd>call terraform#GoToModuleDefinition()<cr>

