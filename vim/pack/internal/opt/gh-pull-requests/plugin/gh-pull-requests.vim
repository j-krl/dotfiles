command! -bang Prweb !gh pr view --web
command! -bang Prbuf call GhPrCreate(1, <bang>0)
command! -bang Prinline call GhPrCreate(0, <bang>0)

cabbrev prc !gh pr create --fill-first
cabbrev prd !gh pr create --fill-first --draft

function! GhPrCreate(buf, draft)
	if a:buf
		let l:title = getline(1)
		let l:body = join(getline(3, '$'), "\n")
	else
		let l:title = input("PR Title: ")
		let l:body = input("PR Body: ")
	endif
	if empty(l:title)
		echoerr "PR title cannot be empty"
		return
	endif
	let l:cmd = "gh pr create --title " .. shellescape(l:title) .. " --body " ..
		\shellescape(l:body)
	let l:output = system(l:cmd .. (a:draft ? " --draft" : "") .. " 2>&1")
	exe (v:shell_error ? "echoerr " : "echomsg ") .. string(l:output)
	if a:buf
		bd!
	endif
endfunction

