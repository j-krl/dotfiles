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
	let tagstack = gettagstack()
	let tagentry = {"bufnr": bufnr("%"), "tagname": paths[-1], "from": [bufnr("%"), line("."), col("."), 0], "matchnr": 1}
	call add(tagstack["items"], tagentry)
	call settagstack(win_getid(), tagstack, 'r')
	exe "e " .. $TERRAFORM_MODULES_DIR .. "/" .. paths[-1] .. "/"
endfunction
