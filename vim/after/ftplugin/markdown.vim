" md sources the html which sets this, so unset
setlocal formatprg=
setlocal spell
iab -] - [ ]
inoremap <expr> <tab> getline(".") =~# "^[ \t]*[\-\*]" ? "<C-T>" : "<tab>"
if executable("glow")
	command! Glow tabnew|exe 'r !glow # -w 120'|set ft=markdown|setl bt=nofile
endif
if executable("prettier")
	command! -range Tabulate :<line1>,<line2>!prettier --parser markdown
endif

