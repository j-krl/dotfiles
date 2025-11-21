if executable("ruff")
		setlocal formatprg=ruff\ format\ --force-exclude\ --stdin-filename\ %
endif
" delete surrounding dict reference
nmap <buffer> dsd di]%hviel%p
nmap <buffer> dsm ds"ds"ds"
" Keyword key-value to dict (cursor on key)
nnoremap <buffer> <localleader>d ciw"<C-R>""<right><backspace>:<space><esc>
" Dict key-value to keyword (cursor on key)
nnoremap <buffer> <localleader>D di"a<backspace><backspace><C-R>"<right><right>
		\<backspace><backspace>=<esc>
nnoremap <buffer> <localleader>b obreakpoint()<esc>
nnoremap <buffer> <localleader>B Obreakpoint()<esc>
" Convert to f-string
nnoremap <buffer> <localleader>F mfF"if<esc>`fl
