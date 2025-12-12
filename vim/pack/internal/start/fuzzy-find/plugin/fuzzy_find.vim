" Fuzzy find files with :find and buffers with :buffer
" Triggering :buffer completion with no pattern also sorts by MRU
"
" TODO: Fix if wildoptions=fuzzy is already set
" TODO: Look into adding wildtrigger() once upgraded to nvim >= 0.12

if !executable('fzf') || !executable('fd')
	finish
endif

let s:TMP_WILDMODE = "noselect:lastused,full"
let s:CMD_PATT = '^find\? \|^b\(uffer\)\? '

set wildmenu
set findfunc=FuzzyFindFunc
if &wildoptions !~# 'pum'
	set wildoptions+=pum
endif

augroup fuzzyfind
	autocmd!
	autocmd VimEnter * let s:wildmode_start = &wildmode
	autocmd CmdlineEnter : let s:wildmode_start = &wildmode
	autocmd CmdlineChanged : if getcmdline() =~# 
		\s:CMD_PATT && &wildmode != s:TMP_WILDMODE | let &wildmode =
		\s:TMP_WILDMODE | endif
	autocmd CmdlineChanged : if getcmdline() =~# '^b\(uffer\)\? ' 
		\&& &wildoptions !~# 'fuzzy' | set wildoptions+=fuzzy | endif
	autocmd CmdlineLeave : if &wildmode != s:wildmode_start ||
		\&wildoptions =~# 'fuzzy' | let &wildmode = s:wildmode_start |
		\set wildoptions-=fuzzy | endif
augroup END

function! FuzzyFindFunc(cmdarg, cmdcomplete)
	" TODO: make native (if performant)
	return systemlist("fd --hidden --type f -E '.g' . | fzf --filter='" ..
		\a:cmdarg .. "'")
endfunction


