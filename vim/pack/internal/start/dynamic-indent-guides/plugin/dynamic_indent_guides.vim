augroup indentguides
	autocmd!
	autocmd OptionSet shiftwidth call s:SetSpaceIndentGuides(v:option_new)
	autocmd BufWinEnter * call s:SetSpaceIndentGuides(&l:shiftwidth)
augroup END

function! s:SetSpaceIndentGuides(sw) abort
	let indent = a:sw
	if indent == 0
		let indent = &tabstop
	endif
	if &l:listchars == ""
		let &l:listchars = &listchars
	endif
	let listchars = substitute(&listchars, 'leadmultispace:.\{-},', '', 'g')
	let newlead = "\┆"
	for i in range(indent - 1)
		let newlead .= "\ "
	endfor
	let newlistchars = "leadmultispace:" .. newlead .. "," .. listchars
	let &l:listchars = newlistchars
endfunction

