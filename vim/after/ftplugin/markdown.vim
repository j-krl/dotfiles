setlocal spell
set iskeyword-=-
" md sources the html which sets this, so unset
setlocal formatprg=
inoremap <expr> <tab> getline(".") =~# "^[ \t]*[\-\*]" ? "<C-T>" : "<tab>"
if executable("glow")
	nnoremap <localleader>p :<C-U>tabnew \| exe 'r !glow # -w 120' \|
		\set ft=markdown \| setlocal buftype=nofile \| 
		\exe "TabooRename [preview]" \| norm gg<cr>
endif
iab -] - [ ]
if executable("prettier")
	command! Tabulate :!prettier --parser markdown
endif

