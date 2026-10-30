command! -bang Prcreate call GhPrBuf("gh pr create" .. (<bang>0 ? " --draft" : ""), 1, GhPrFillFirst())
command! -bang Prready exe "!gh pr ready" .. (<bang>0 ? " --undo" : "")
command! Prdcreate !gh pr create --fill-first --draft
command! Prebody call GhPrEdit()
command! Pretitle !gh pr edit --title
command! Prfdiff exe "Scratch" | call setline(1, systemlist("gh pr diff --color=never")) | setlocal filetype=git
command! Printegration !gh pr checks | column -t -s $'\t'
command! Prqcreate !gh pr create --fill-first
command! Prstatus !gh pr view --json mergeStateStatus,mergeable
command! Prupdate !gh pr update-branch
command! Prview !gh pr view
command! Prwview !gh pr view --web
command! Prx call GhPrClose()

command! -bang Ypr let @+ = trim(system("gh pr view --json url --jq .url"))

cabbrev ghp !gh pr

function! GhPrClose() abort
	let l:number = system("gh pr view --json number --jq .number")
	if v:shell_error
		echoerr l:number
		return
	endif
	let l:output = system("gh pr close " .. trim(l:number))
	exe (v:shell_error ? "echoerr " : "echomsg ") .. string(l:output)
endfunction

function! GhPrFillFirst() abort
	let l:trunk = trim(system("git symbolic-ref --short refs/remotes/origin/HEAD"))
	let l:revs = systemlist("git rev-list " .. l:trunk .. "..HEAD")
	if v:shell_error || empty(l:revs)
		return ['']
	endif
	return systemlist("git show -s --format=%B " .. l:revs[-1])
endfunction

function! GhPrEdit() abort
	let l:body = system("gh pr view --json body --jq .body")
	if v:shell_error
		echoerr l:body
		return
	endif
	call GhPrBuf("gh pr edit", 0, split(substitute(l:body, '\r', '', 'g'), '\n'))
endfunction

function! GhPrBuf(cmd, title, lines) abort
	Scratch
	setlocal buftype=acwrite filetype=markdown
	exe "silent file gh://pr-" .. bufnr('')
	call setline(1, a:lines)
	let b:gh_pr_cmd = a:cmd
	let b:gh_pr_title = a:title
	autocmd BufWriteCmd <buffer> call GhPrSubmit(str2nr(expand('<abuf>')))
endfunction

function! GhPrSubmit(buf) abort
	let l:lines = getbufline(a:buf, 1, '$')
	let l:cmd = getbufvar(a:buf, 'gh_pr_cmd')
	if getbufvar(a:buf, 'gh_pr_title')
		let l:body = join(l:lines[2:], "\n")
		if empty(l:lines[0])
			echoerr "PR title cannot be empty"
			return
		endif
		let l:cmd ..= " --title " .. shellescape(l:lines[0])
	else
		let l:body = join(l:lines, "\n")
	endif
	let l:output = system(l:cmd .. " --body " .. shellescape(l:body))
	if v:shell_error
		echoerr l:output
		return
	endif
	call setbufvar(a:buf, '&modified', 0)
	echomsg l:output
endfunction
