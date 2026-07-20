command! Argappend $arge %|argded|redrawstatus|args
command! Argprepend 0arge %|argded|redrawstatus|args
command! Argdelete argd %|echo ""|redrawstatus|argu|args
command! Argclear %argd|echo "arglist cleared"
command! Arglclear argl|%argd|echo "local arglist created"
command! -count -addr=arguments Argu exe (<count> > 0 ? <count> : "") .. "argu"|args
command! -nargs=+ Argfind exe "args `fd --hidden --type f -E '.git' --full-path '" 
    \.. <q-args> .. "'`" | args
command! -nargs=? -complete=customlist,GitBranchComplete Argdifftool 
    \exe "args `git diff " .. <q-args> .. " --name-only`" | let @b = <q-args> |
    \args

cabbrev aa Argappend
cabbrev ax Argclear
cabbrev ad Argdelete

nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr><esc>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
" Diff arglist diffs set with :Argdifftool
nmap <leader>]a ]a:<C-U>wincmd o\|Gvdiffsplit<space><C-R>b<cr>
nmap <leader>[a [a:<C-U>wincmd o\|Gvdiffsplit<space><C-R>b<cr>
nnoremap <expr> <space><space> ":<C-U>" .. v:count .. "Argu<cr><esc>"

" Allows wrapping for ]a and [a arglist mappings
function! NavArglist(count)
	let arglen = argc()
	if arglen == 0
		return
	endif
	let next = fmod(argidx() + a:count, arglen)
	if next < 0
		let next += arglen
	endif
	exe float2nr(next + 1) .. 'argu'
endfunction

function! GitBranchComplete(ArgLead, CmdLine, CursorPos)
    let l:branches = systemlist("git branch --format='%(refname:short)'")
    return filter(l:branches, 'v:val =~ "^' . a:ArgLead . '"')
endfunction

