hi clear Boolean
hi clear Constant
hi clear Delimiter
hi clear Label
hi clear Macro
hi clear Number
hi clear Type
hi! link Identifier Function
hi! link Include Statement
hi! link Operator Normal
hi! link PreProc Function
hi! link Special Function
hi! link SpecialChar Special
hi! link String Type
hi! link Structure Statement
hi! link @variable Normal

if &background == "dark"
	hi Normal guifg=#ebdbb2 guibg=#282828
	hi String ctermfg=214 guifg=#fabd2f
	"hi Identifier cterm=bold ctermfg=142 gui=bold guifg=#b8bb26
else
	hi String ctermfg=172 guifg=#b57614
	"hi Identifier cterm=bold ctermfg=64 gui=bold guifg=#79740e
endif
