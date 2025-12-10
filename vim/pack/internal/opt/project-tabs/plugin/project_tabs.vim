command! -nargs=1 -complete=customlist,s:CompleteOpenProjFuzzy Prjopen call s:GoToProj(<f-args>)
command! Prjonly call s:OnlyProj()
command! Prjtodo exe "pedit +1 " .. getcwd(-1, -1) .. "/TODO.md"|wincmd p"

function s:GoToProj(query) abort
	let projs = []
	for i in range(1, tabpagenr('$'))
		let proj = TabooTabName(i)
		if proj == ""
			let proj = split(getcwd(-1, i), "/")[-1]
		endif
		call add(projs, {"name": proj, "nr": i})
	endfor
	for f in globpath(getcwd(-1, -1), "*", 0, 1)
		let tail = fnamemodify(f, ":t")
		if isdirectory(f)
			call add(projs, {"name": tail, "nr": -1})
		endif
	endfor
	let matchlist = matchfuzzy(projs, a:query, {"key": "name"})
	if len(matchlist) == 0
		echoerr "No matching projects"
		return
	endif
	if matchlist[0].nr == -1
		let path = getcwd(-1, -1) .. "/" .. matchlist[0].name
		tabnew
		exe "tcd " .. path
		Explore
	else
		exe "tabnext " .. matchlist[0].nr
	endif
endfunction

" The common pattern is to open nvim from some parent folder containing many
" projects, and then open those projects in their own tabs. This function
" closes all tabs which are projects with the same parent directory as the
" global cwd, except the currently focused tab.
function s:OnlyProj() abort
	let i = 1
	let currproj = getcwd(-1)
	while i <= tabpagenr('$')
		let tabcwd = getcwd(-1, i)
		let globcwd = getcwd(-1, -1)
		if tabcwd != currproj && tabcwd != globcwd && 
			\fnamemodify(tabcwd, ":h") == globcwd
			exe "tabclose " .. i
		else
			let i += 1
		endif
	endwhile
endfunction

function s:CompleteOpenProjFuzzy(ArgLead, CmdLine, CursorPos) abort
	let cwd = getcwd(-1, -1)
	let items = map(range(1, tabpagenr('$')), {_, val -> split(getcwd(-1, val), "/")[-1]})
	let dirs = []
	for f in globpath(cwd, "*", 0, 1)
		let tail = fnamemodify(f, ":t")
		if isdirectory(f)
			call add(dirs, tail)
		endif
	endfor
	let all = uniq(sort(items + dirs))
	if a:ArgLead == ""
		return all
	endif
	let matchlist = matchfuzzy(all, a:ArgLead)
	return matchlist
endfunction

