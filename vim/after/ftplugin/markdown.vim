" md sources the html which sets this, so unset
setlocal formatprg=
setlocal spell
iab -] - [ ]
inoremap <expr> <tab> getline(".") =~# "^[ \t]*[\-\*]" ? "<C-T>" : "<tab>"
if executable("glow")
	command! Glow tabnew | exe 'r !glow # -w 120' | set ft=markdown |
		\setlocal buftype=nofile | exe "TabooRename [preview]" | 1
endif
if executable("prettier")
	command! -range Tabulate :<line1>,<line2>!prettier --parser markdown
endif

