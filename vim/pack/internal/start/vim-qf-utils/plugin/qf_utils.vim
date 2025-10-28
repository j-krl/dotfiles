let g:qflists = {}

augroup qfutils
	autocmd!
augroup END

nnoremap <expr> [h "<cmd>colder " .. v:count1 .. "\|cwindow<cr>"
nnoremap <expr> ]h "<cmd>cnewer " .. v:count1 .. "\|cwindow<cr>"
nnoremap [H <cmd>1chistory\|cw<cr>
nnoremap <expr> ]H "<cmd>" .. getqflist({'nr': '$'}).nr .. "chistory\|cwindow<cr>"
nnoremap <expr> [2 "<cmd>lolder " .. v:count1 .. "\|lwindow<cr>"
nnoremap <expr> ]2 "<cmd>lnewer " .. v:count1 .. "\|lwindow<cr>"
nnoremap [@ <cmd>1lhistory\|cw<cr>
nnoremap <expr> ]@ "<cmd>" .. getloclist(0, {'nr': '$'}).nr .. "lhistory\|lwindow<cr>"

command! -nargs=? Cfsave call SaveQfFile(<q-args>)
command! -nargs=? Cfload call LoadQfFile(<q-args>)
command! -nargs=? Cfdelete call DeleteQfFile(<q-args>)
command! -count Chdelete call DeleteQf(<count>)
command! Chclear call setqflist([], 'f')|ccl|chistory
command! -count -nargs=1 Csave call SaveQf(<q-args>, <count>)
" TODO: make argument optional and just grab the latest list if no arg
command! -nargs=1 -complete=customlist,s:CompleteQfNames Cload call setqflist([], ' ', 
		\{"title": <q-args>, "items": g:qflists[<q-args>].items, "nr": "$"})|cwindow|1cc
command! -nargs=1 -complete=customlist,s:CompleteQfNames Cdelete unlet g:qflists[<q-args>]
command! Clist echo keys(g:qflists)
command! Cclear let g:qflists = {}
command! Cwipe Chclear|Cclear
command! -nargs=1 Crename call RenameQf(<q-args>)
command! -count=1 Cditem call DeleteQfItems(<count>)
command! -count=1 Lditem call DeleteQfItems(<count>, 1)
command! -nargs=+ Cfuzzy call FuzzyFilterQf(<f-args>)
command! -nargs=+ -complete=file_in_path Cfind call FdQf(<f-args>)

autocmd qfutils QuickFixCmdPost [^l]* exe "norm mG"|cwindow
autocmd qfutils QuickFixCmdPost l* exe "norm mG"|lwindow
autocmd qfutils VimEnter * if get(g:, "qf_session_auto_load", 0) && !empty(v:this_session) 
	\| call LoadQfFile("", 0) | endif
autocmd qfutils VimLeave * if get(g:, "qf_session_auto_cache", 0) > 0 && !empty(v:this_session) 
	\| call SaveQfFile("", get(g:, "qf_session_auto_cache", 0)) | endif

function! FuzzyFilterQf(...) abort
	let matchstr = join(a:000, " ")
	let filtered_items = matchfuzzy(getqflist(), matchstr, {'key': 'text'})
	call setqflist([], " ", {"nr": "$", "title": ":Cfuzzy /" .. matchstr .. "/", "items": filtered_items})
endfunction

function! FdQf(...) abort
	let args = join(a:000, " ")
	let fdcmd = "fd -t f --hidden " .. args
	let fdresults = systemlist(fdcmd)
	if v:shell_error
		echoerr "Fd error: " .. fdresults[0]
		return
	endif
	let listresults = map(fdresults, {_, val -> {'filename': val, 'lnum': 1, 'text': val}})
	call setqflist([], ' ', {'nr': '$', 'title': fdcmd, 'items': listresults})
	cwindow
endfunction

function! DeleteQfItems(count, loc=0) abort
	if !a:loc
		let qf = getqflist({'nr': 0, 'idx': 0, 'title': 0, 'items': 0})
	else
		let qf = getloclist(0, {'nr': 0, 'idx': 0, 'title': 0, 'items': 0})
	endif
	if qf.idx == 0
		echoerr "No errors"
		return
	endif
	let idx_list = range(qf.idx - 1, qf.idx + a:count - 2)
	let filtered_items = filter(qf.items, {idx -> index(idx_list, idx) == -1})
	if !a:loc
		call setqflist([], 'r', {'items': filtered_items, 'title': qf.title})
	else
		call setloclist(0, [], 'r', {'items': filtered_items, 'title': qf.title})
	endif
	if len(filtered_items) > 0
		exe qf.idx .. (!a:loc ? 'cc' : 'll')
	endif
endfunction

function! SaveQfFile(filename="", mode=1) abort
	let file = s:GetQfFilename(a:filename)
	let lists = []
	let numqfs = getqflist({'nr': '$'}).nr
	if a:mode == 1
		for nr in range(1, numqfs)
			let curlist = getqflist({"nr": nr, "items": 1, "title": 1})
			call s:AddQfFilenames(curlist.items)
			let curlist["name"] = ""
			call add(lists, string(curlist))
		endfor
	endif
	if a:mode == 1 || a:mode == 2
		for key in keys(g:qflists)
			let entry = g:qflists[key]
			let curlist = {"items": entry.items, "title": entry.title, "name": key}
			call s:AddQfFilenames(curlist.items)
			call add(lists, string(curlist))
		endfor
	endif
	if len(lists) > 0
		call writefile(lists, file)
	else
		call DeleteQfFile(a:filename)
	endif
endfunction

function! LoadQfFile(filename="", echo=1) abort
	let file = s:GetQfFilename(a:filename)
	try
		let filelists = readfile(file)
	catch
		if a:echo
			echoerr "No qf file " .. file
		endif
		return
	endtry
	call setqflist([], 'f')
	for entry in filelists
		let curlist = eval(entry)
		let qfdict = {"title": curlist.title, "items": curlist.items}
		if curlist.name == ""
			call setqflist([], ' ', qfdict)
		else
			let g:qflists[curlist.name] = qfdict
		endif
	endfor
	if a:echo
		chistory
	endif
endfunction

function! DeleteQfFile(filename="") abort
	let file = s:GetQfFilename(a:filename)
	let delresult = system("rm " .. file)
	if v:shell_error
		echoerr delresult
	endif
endfunction

function! DeleteQf(nr=0) abort
	let delnr = a:nr
	let curnr = getqflist({'nr': 0}).nr
	if delnr == 0
		let delnr = curnr
	endif
	let qflen = getqflist({'nr': '$'}).nr
	if qflen < delnr
		echoerr "Invalid qf number"
	endif
	let qfold = []
	for entry in range(1, qflen)
		call add(qfold, getqflist({'nr': entry, 'items': 1, 'title': 1}))
	endfor
	call setqflist([], 'f')
	let oldnr = 1
	for entry in qfold
		if oldnr != delnr
			call setqflist([], ' ', {'title': entry.title, 'items': entry.items})
		endif
		let oldnr += 1
	endfor
	if delnr == curnr
		exe 'sil ' .. (qflen - 1) .. 'chistory'
		ccl
	else
		exe 'sil ' .. (delnr < curnr ? curnr - 1 : curnr) .. 'chistory'
	endif
	chistory
endfunction

function! RenameQf(title) abort
	let qf = getqflist({"nr": 0, "items": 0})
	call setqflist([], 'u', {"nr": 0, "title": a:title, "items": qf.items})
endfunction

function! SaveQf(name, nr=0) abort
	let qf = getqflist({"nr": a:nr, "title": 1, "items": 1})
	let g:qflists[a:name] = {"title": qf.title, "items": qf.items}
	echo 'Saved qflist ' .. a:name
	call setqflist([], 'u', {"nr": a:nr, "title": a:name, "items": qf.items})
endfunction

function s:CompleteQfNames(ArgLead, CmdLine, CursorPos)
	let completions = []
	for name in keys(g:qflists)
		if name =~ a:ArgLead
			call add(completions, name)
		endif
	endfor
	return completions
endfunction

function! s:GetQfFilename(filename) abort
	if a:filename == ""
		let tail = slice(substitute(getcwd(-1, -1), '/', '-', 'g'), 1)
	else
		let tail = a:filename
	endif
	let dir = get(g:, "qf_cache_dir", "./")
	return dir .. tail .. ".qf"
endfunction

function! s:AddQfFilenames(qflist)
	if has_key(a:qflist[0], 'filename')
		return
	endif
	for entry in a:qflist
		let entry.filename = expand("#" .. entry.bufnr .. ":p")
		unlet entry.bufnr
	endfor
endfunction
