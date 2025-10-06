if has("nvim")
    hi TabLineSel gui=reverse
    if &background == "dark"
        hi Statement ctermfg=14 guifg=NvimLightCyan
    else
        hi Statement ctermfg=6 guifg=NvimDarkCyan
    endif
endif
