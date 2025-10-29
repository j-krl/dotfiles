hi Comment guifg=grey50
hi TablineSel gui=REVERSE
hi TreesitterContextBottom gui=underline guisp=Grey

if !has("nvim")
	hi! link VertSplit StatusLineNC
endif

if &background == "dark"
	hi QuickScopeSecondary guifg=yellow
	hi QuickScopePrimary guifg=orchid
	hi Visual guifg=NONE gui=NONE guibg=grey35
	hi DiffAdd gui=BOLD guifg=NONE guibg=#2e4b2e
	hi DiffDelete gui=BOLD guifg=NONE guibg=#4c1e15
	hi DiffChange gui=BOLD guifg=NONE guibg=#515f64
	hi DiffText gui=BOLD guifg=NONE guibg=#5c4306
	hi diffAdded guifg=lawngreen
	hi diffRemoved guifg=tomato
else
	hi QuickScopeSecondary guifg=tan3
	hi QuickScopePrimary guifg=orchid3
	hi Visual guifg=NONE gui=NONE guibg=grey75
	hi DiffAdd gui=BOLD guifg=NONE guibg=palegreen
	hi DiffDelete gui=BOLD guifg=NONE guibg=lightred
	hi DiffChange gui=BOLD guifg=NONE guibg=lightblue
	hi DiffText gui=BOLD guifg=NONE guibg=palegoldenrod
	hi diffAdded guifg=green
	hi diffRemoved guifg=red
	if has("nvim")
		hi DiagnosticHint guifg=DarkGrey
	endif
endif

