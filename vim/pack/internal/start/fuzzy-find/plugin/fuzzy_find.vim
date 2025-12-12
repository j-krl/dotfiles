" Fuzzy find files with :find and buffers with :buffer.
"
" Caches find files for better performance on subsequent completion triggers.
" Triggering :buffer completion with no pattern also sorts by MRU.
"
" TODO: Broken if wildoptions=fuzzy is already set
" TODO: Look into adding wildtrigger() once upgraded to nvim >= 0.12

if !executable('fzf') || !executable('fd')
	finish
endif

let s:TMP_WILDMODE = "noselect:lastused,full"
let s:CMD_PATT = '^find\? \|^b\(uffer\)\? '
let s:FMD_CMD = "fd --hidden --type f -E '.git' ."
let s:find_cache = ""

set wildmenu
set findfunc=FuzzyFindFunc
if &wildoptions !~# 'pum'
	set wildoptions+=pum
endif

augroup fuzzyfind
	autocmd!
	autocmd VimEnter * let s:wildmode_start = &wildmode
	autocmd CmdlineEnter : let s:wildmode_start = &wildmode
	" Set up correct wildmode for :find and :buffer
	autocmd CmdlineChanged : if getcmdline() =~# 
		\s:CMD_PATT && &wildmode != s:TMP_WILDMODE | let &wildmode =
		\s:TMP_WILDMODE | endif
	" Set up fuzzy matching for buffers
	autocmd CmdlineChanged : if getcmdline() =~# '^b\(uffer\)\? ' 
		\&& &wildoptions !~# 'fuzzy' | set wildoptions+=fuzzy | endif
	" Populate filename cache for :find once 'fin' is entered. This is
	" optional as the first completion trigger will also populate an empty
	" cache
	autocmd CmdlineChanged : if getcmdline() =~# '^fin'
		\&& s:find_cache == "" | let s:find_cache = system(s:FD_CMD) | endif
	" Set wildmode and wildoptions back to original values
	autocmd CmdlineLeave : if &wildmode != s:wildmode_start ||
		\&wildoptions =~# 'fuzzy' | let &wildmode = s:wildmode_start |
		\set wildoptions-=fuzzy | endif
	" Empty the find cache
	autocmd CmdlineLeave : if s:find_cache != "" | let s:find_cache = "" |
		\endif
augroup END

function! FuzzyFindFunc(cmdarg, cmdcomplete)
	if s:find_cache == ""
		let s:find_cache = system(s:FD_CMD) 
	endif
	return systemlist("fzf --filter='" .. a:cmdarg .. "'", s:find_cache)
endfunction

