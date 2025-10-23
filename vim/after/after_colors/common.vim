hi clear PreProc
hi clear Type
hi clear Constant
hi Constant gui=BOLD
hi! link NonText Comment
hi! link Boolean Constant
hi! link Float Constant
hi! link Number Constant
hi! link Include Statement
hi! link Operator Statement
hi! link Special Statement
hi! link Structure Function
hi! link Function Identifier
hi! link Delimiter Statement
hi Comment guifg=grey50
hi! link diffAdded DiffAdd
hi! link diffRemoved DiffDelete

if !has("nvim")
	hi! link VertSplit StatusLineNC
endif

if &background == "dark"
	hi Visual guifg=NONE gui=NONE guibg=grey35
	hi DiffAdd gui=BOLD guifg=NONE guibg=#2e4b2e
	hi DiffDelete gui=BOLD guifg=NONE guibg=#4c1e15
	hi DiffChange gui=BOLD guifg=NONE guibg=#515f64
	hi DiffText gui=BOLD guifg=NONE guibg=#5c4306
else
	hi Visual guifg=NONE gui=NONE guibg=grey75
	hi DiffAdd gui=BOLD guifg=NONE guibg=palegreen
	hi DiffDelete gui=BOLD guifg=NONE guibg=lightred
	hi DiffChange gui=BOLD guifg=NONE guibg=lightblue
	hi DiffText gui=BOLD guifg=NONE guibg=palegoldenrod
	if has("nvim")
		hi DiagnosticHint guifg=DarkGrey
	endif
endif

" vimscript
hi! link vimBracket Identifier
hi! link vimCommentString Comment
" markdown
hi! link mkdHeading Statement
hi! link Title Statement
hi! link mkdLineBreak Normal
" python
hi! link pythonFunctionCall Normal
hi! link pythonClassVar Function
hi! link pythonBuiltinType Normal
hi! link pythonBuiltinFunc Normal
" typescript
hi! link typescriptMember Normal
hi! link typescriptObjectLabel Normal
hi! link typescriptTypeReference Normal
hi! link typescriptVariable Statement
hi! link typescriptEnumKeyword Statement
hi! link typescriptAssign Operator
hi! link typescriptOperator Operator
hi! link typescriptObjectColon Operator
hi! link typescriptTypeAnnotation Operator
hi! link jsxBraces Identifier
" json
hi! link jsonKeyword Statement
