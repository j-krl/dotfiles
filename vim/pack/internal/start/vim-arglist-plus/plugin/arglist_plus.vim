command! Argappend $arge %|argded|redrawstatus|args
command! Argprepend 0arge %|argded|redrawstatus|args
command! Argrm argd %|echo ""|redrawstatus|args
command! Argclear %argd|echo "arglist cleared"
command! Arglclear argl|%argd|echo "local arglist created"
command! -count -addr=arguments Argu exe (<count> > 0 ? <count> : "") .. "argu"|args
command! -nargs=+ Argfind exe "arga `fd --hidden --type f -E '.git' --full-path '" .. <q-args> .. "'`"

nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr>
nnoremap [A <cmd>first<bar>args<cr>
nnoremap ]A <cmd>last<bar>args<cr>

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
