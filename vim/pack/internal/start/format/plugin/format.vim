let g:format_on_save = get(g:, 'format_on_save', 0)

command! FmtBuf call s:FormatBuf()
command! -bang Wfmt call FormatSave(<bang>1, v:false)
command! -bang Wafmt call FormatSave(<bang>1, v:true)
command! -bang FmtSaveSet let g:format_on_save = <bang>0

augroup format
	autocmd!
	autocmd BufWritePre * if g:format_on_save | call s:FormatBuf() | endif
augroup END

" Save and specify if buffer(s) should be formatted regardless of current
" g:format_on_save setting
function! s:FormatSave(fmt, all) abort
	let orig_setting = g:format_on_save
	let g:format_on_save = a:fmt
	if a:all
		wa
	else
		w
	endif
	let g:format_on_save = orig_setting
endfunction

function! s:FormatBuf() abort
	if &formatprg == ""
		return
	endif
	let l:view = winsaveview()
	" Best we can do to prevent mangling the undo history after formatting
	sil! undojoin | norm gggqG
	call winrestview(l:view)
endfunction

