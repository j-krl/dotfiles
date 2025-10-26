command! -nargs=1 -complete=customlist,s:CompleteOpenProjFuzzy Prjopen call s:GoToProj(<f-args>)
command! -nargs=1 -complete=customlist,s:CompleteNewProj Prjnew call s:NewProj(<f-args>)
command! -nargs=0 Prjonly call s:OnlyProj()

function s:GoToProj(query) abort
	let projs = []
	for i in range(1, tabpagenr('$'))
		let proj = TabooTabName(i)
		if proj == ""
			let proj = split(getcwd(-1, i), "/")[-1]
		endif
		call add(projs, {"name": proj, "nr": i})
	endfor
	let matchlist = matchfuzzy(projs, a:query, {"key": "name"})
	if len(matchlist) == 0
		echoerr "No matching projects"
		return
	endif
	exe "tabnext " .. matchlist[0].nr
endfunction

function s:NewProj(dirname) abort
	for i in range(1, tabpagenr('$'))
		let tabproj = split(getcwd(-1, i), "/")[-1]
		if tabproj == a:dirname
			exe "tabnext " .. i
			return
		endif
	endfor
	let cwd = getcwd(-1, -1)
	let proj = cwd .. "/" .. a:dirname
	if !isdirectory(proj)
		echoerr a:dirname .. " is not a directory"
		return
	endif
	tabnew
	exe "tcd " .. proj
	Explore
endfunction

function s:OnlyProj() abort
	if tabpagenr() == 1 || tabpagenr('$') <= 2
		return
	endif
	$tabmove 
	for i in range(2, tabpagenr('$') - 1)
		2tabclose
	endfor
	$tabnext
endfunction

function s:CompleteOpenProjFuzzy(ArgLead, CmdLine, CursorPos) abort
	let items = map(range(1, tabpagenr('$')), {_, val -> split(getcwd(-1, val), "/")[-1]})
	if a:ArgLead == ""
		return items
	endif
	let matchlist = matchfuzzy(items, a:ArgLead)
	return matchlist
endfunction

function s:CompleteNewProj(ArgLead, CmdLine, CursorPos) abort
	let cwd = getcwd(-1, -1)
	let dirs = []
	for f in globpath(cwd, "*", 0, 1)
		let tail = fnamemodify(f, ":t")
		if isdirectory(f) && tail =~ a:ArgLead
			call add(dirs, tail)
		endif
	endfor
	return dirs
endfunction

