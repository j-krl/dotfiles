function! terraform#GoToModuleDefinition() abort
	if empty($TERRAFORM_MODULES_DIR)
		echoerr "TERRAFORM_MODULES_DIR not set"
		return
	endif
	norm "dyi"
	let paths = split(@d, '//')
	if len(paths) != 2
		echoerr "Invalid module path"
		return
	endif
	exe "e " .. $TERRAFORM_MODULES_DIR .. "/" .. paths[-1] .. "/"
endfunction
