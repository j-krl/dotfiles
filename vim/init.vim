function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('unblevable/quick-scope')
	call minpac#add('jeetsukumaran/vim-indentwise')
	call minpac#add('christoomey/vim-tmux-navigator')
	call minpac#add('gcmt/taboo.vim')
	call minpac#add('justinmk/vim-dirvish')
	call minpac#add('kylechui/nvim-surround')
	call minpac#add('tpope/vim-obsession')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-rhubarb')
	call minpac#add('tpope/vim-sleuth')
	call minpac#add('github/copilot.vim')
	call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('ibhagwan/fzf-lua')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
	call minpac#add('nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'})
	call minpac#add('nvim-treesitter/nvim-treesitter-textobjects', {'branch': 'master'})
	call minpac#add('Wansmer/treesj')
	call minpac#add('HiPhish/rainbow-delimiters.nvim')
endfunction
packadd cfilter

exe "source " .. stdpath("config") .. "/vimrc"
lua require('config')

"""""""""""
" Options "
"""""""""""

colo default
let g:maplocalleader = "_"
set termguicolors
set wildmenu
set wildmode=noselect:longest:lastused,full
set nofixeol
" Required for taboo to persist names in sessions
set sessionoptions+=globals
set completeopt=menuone,popup
set foldopen-=search
set list
set listchars=tab:\│\ ,precedes:>,extends:<
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,**/.git/*,**/build/*,**/__pycache__/*
set wildoptions=pum,tagfile
set wildcharm=<tab>
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git/*'
set tabclose=left
set guicursor=n-v-c-sm:block,i-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor
set spellcapcheck=
set fillchars=diff:\
" Add session status and arglist position to statusline
set statusline=%{ObsessionStatus()}\ %<%f\ \ %{FugitiveStatusline()}%h%m%r%=[%n]\ %-13a%-13(%l,%c%V%)\ %P
let &packpath = stdpath("data") .. "/site," .. substitute(&packpath, stdpath("data") .. "/site,", "", "g")

if exists('&findfunc') && executable('fd') && executable('fzf')
	set findfunc=FuzzyFindFunc
endif

function! FuzzyFindFunc(cmdarg, cmdcomplete)
	return systemlist("fd --hidden --type f -E '.git' . | fzf --filter='" .. a:cmdarg .. "'")
endfunction

""" Plugin options """
" Sort directories above
let g:dirvish_mode = ':sort ,^.*[\/],'
" Disable netrw
let g:loaded_netrwPlugin = 1
let g:python_indent = {
		\'open_paren': 'shiftwidth()',
		\'closed_paren_align_last_line': v:false
	\}
let g:vim_indent_cont = shiftwidth()
let g:markdown_fenced_languages = ["python", "javascript", "javascriptreact",
	\"typescript", "typescriptreact", "html", "css", "json", "vim", "lua",
	\"go"]
let g:copilot_no_tab_map = v:true
let g:copilot_filetypes = {
		\'markdown': v:false,
		\'copilot-chat': v:false
	\}
let g:tmux_navigator_no_mappings = 1
let g:taboo_tab_format = " %N %P "
let g:taboo_renamed_tab_format = " %N %l "
let g:qf_session_auto_cache = 1
let g:qf_session_auto_load = 1
let g:qf_cache_dir = expand("~") .. "/.cache/vim/"
let g:format_on_save = 1
let g:compare_branch = "master"
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git', 'main.tf'] " TODO: need better tf root
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_exclude = [ '*.git', '*.svg', '*.hg', 'build', 'dist', 
	\'bin', 'node_modules', 'venv', '.venv', 'cache', 'docs', 'example', 
	\'*.md', '*.lock', '*bundle*.js', '*build*.js', '.*rc*', '*.json', 
	\'*.min.*', '*.bak', '*.zip', '*.pyc', '*.tmp', '*.cache', 'tags*', 
	\'*.css', '*.scss', '*.swp', '.terraform'
	\]

""""""""""""
" Mappings "
""""""""""""

noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap <silent> - :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>:Explore<cr>
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap yr~ :let @+ = expand("%:~")<cr>
nnoremap yr` :let @+ = expand("%:~:h")<cr>
nnoremap yr. :let @+ = expand("%:.")<cr>
nnoremap yr> :let @+ = expand("%:.:h")<cr>
nnoremap yrp :let @+ = expand("%:p")<cr>
nnoremap yrP :let @+ = expand("%:p:h")<cr>
nnoremap yr+ :let @+ = @0<cr>
nmap yr0 yr+
nnoremap yrc :let @+ = system("git branch --show-current")<cr>
" opposite of :h
nnoremap yrt :let @+ = substitute(@+, "[^\/]*\/", "", "")<cr>
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
nnoremap [@ <cmd>1lhistory\|cw<cr>
nnoremap <expr> ]@ "<cmd>" .. getloclist(0, {'nr': '$'}).nr .. "lhistory\|lwindow<cr>"
nnoremap <expr> [2 "<cmd>lolder " .. v:count1 .. "\|lwindow<cr>"
nnoremap <expr> ]2 "<cmd>lnewer " .. v:count1 .. "\|lwindow<cr>"
nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr><esc>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
nnoremap ]f <cmd>call NavDirFiles(v:count1)<cr>
nnoremap [f <cmd>call NavDirFiles(v:count1 * -1)<cr>
nnoremap <expr> [h "<cmd>colder " .. v:count1 .. "\|cwindow<cr>"
nnoremap <expr> ]h "<cmd>cnewer " .. v:count1 .. "\|cwindow<cr>"
nnoremap [H <cmd>1chistory\|cw<cr>
nnoremap <expr> ]H "<cmd>" .. getqflist({'nr': '$'}).nr .. "chistory\|cwindow<cr>"
nnoremap <F2> <C-L><cmd>args<cr>
noremap <F9> <cmd>CopilotChatToggle<cr>
noremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
noremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
noremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
noremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>
" Join lines like 'J' without space between
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. 
	\(v:count < 2 ? v:count - 1: v:count - 2) .. 's/\n\s*//g<cr>`l'
nnoremap <expr> <C-W>C "<cmd>" .. repeat("tabcl\|", v:count1) .. "<cr>"
nnoremap <C-W>D <cmd>tcd %:h<cr>
nnoremap <C-W>N <cmd>tabnew\|Explore<cr>
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>Z <C-W>_<C-W>\|
nnoremap <expr> <A-j> ":<C-U>m +" .. v:count1 .. " <cr>"
nnoremap <expr> <A-k> ":<C-U>m -" .. (v:count1 + 1) .. " <cr>"
" Open file explorer at cwd
nnoremap <space>- :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>
	\exe "Explore " .. getcwd()<cr>
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
nnoremap <space>s a<cr><esc>k$
nnoremap <space>S i<cr><esc>k$
nnoremap <expr> <space><space> ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"
nnoremap <leader>aa <cmd>$arge %<bar>argded<bar>args<cr>
nnoremap <leader>ap <cmd>0arge %<bar>argded<bar>args<cr>
nnoremap <leader>ad <cmd>argd %<bar>args<cr>
nnoremap <leader>ac <cmd>%argd<cr><C-L><cmd>echo "arglist cleared"<cr>
nnoremap <leader>aC <cmd>argl\|%argd\|echo "local arglist created"<cr>
" TODO: switch to command
nnoremap <leader>af :<C-U>arga `fd --hidden --type f -E '.git' --full-path ''`<left><left>
nnoremap <leader>b :<C-U>b<space><tab>
nnoremap <leader>cc <cmd>cwindow<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <expr> <leader>ch "<cmd>" .. (v:count > 0 ? v:count : "")
	\.. "chistory" .. (v:count > 0 ? "\|cw" : "") .. "<cr>"
nnoremap <leader>cL <cmd>echo len(getqflist())<cr>
nnoremap <leader>f :<C-U>find<space>
nnoremap <leader>F :<C-U>find <C-R>=expand("%:.:h")<cr>/<tab>
nnoremap <leader>gg :<C-U>grep ''<left>
nnoremap <leader>gG :<C-U>Pgrep ''<left>
nnoremap <leader>gl :<C-U>lgrep ''<left>
nnoremap <leader>gL :<C-U>Plgrep ''<left>
nnoremap <leader>p :<C-U>Prjopen<space><tab>
nnoremap <leader>ll <cmd>lwindow<cr>
nnoremap <leader>L <cmd>lclose<cr>
nnoremap <expr> <leader>lh "<cmd>" .. (v:count > 0 ? v:count : "")
	\.. "lhistory" .. (v:count > 0 ? "\|cw" : "") .. "<cr>"
nnoremap <leader>lL <cmd>echo len(getloclist(winnr()))<cr>
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>tj <cmd>TSJJoin<cr>
nnoremap <leader>ts <cmd>TSJSplit<cr>
nnoremap <expr> <leader>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <leader>S v:count >= 1 ? ":s/<C-R><C-W>/" : ":%s/<C-R><C-W>/"
nnoremap <leader>x <cmd>xa<cr>
nnoremap <leader>zz mZ<cmd>FzfLua live_grep_native<cr>
nnoremap <leader>zZ mZ<cmd>lua require("fzf-lua").live_grep_native({ cwd = vim.fn.expand("%:h:.") })<cr>
nnoremap <leader>zc mZ<cmd>FzfLua grep_cword<cr>
nnoremap <leader>zC mZ<cmd>lua require("fzf-lua").grep_cword({ cwd = vim.fn.expand("%:h:.") })<cr>
nnoremap <leader>zf mZ<cmd>FzfLua grep<cr><cr>
nnoremap <leader>zF mZ<cmd>lua require("fzf-lua").grep({ cwd = vim.fn.expand("%:h:.") })<cr><cr>
nnoremap <leader>zs mZ<cmd>FzfLua lsp_live_workspace_symbols<cr>
nnoremap <leader>zr mZ<cmd>FzfLua lsp_references<cr>
nnoremap <leader>z- mZ<cmd>FzfLua resume<cr>

xnoremap <silent> il g_o^
xnoremap <silent> al $o0
xnoremap <silent> iq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> aq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> iQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
xnoremap <silent> aQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
xnoremap <expr> <A-j> ":m '>+" .. v:count1 .. "<CR>gv=gv"
xnoremap <expr> <A-k> ":m '<-" .. (v:count1 + 1) .. "<CR>gv=gv"

" Hungry delete
inoremap <silent> <expr> <bs> !search('\S','nbW',line('.')) ? 
	\(col('.') != 1 ? "\<C-U>" : "") .. "\<bs>" : "\<bs>"
inoremap {<cr> {<cr>}<C-O>O
inoremap {<tab> {}<esc>i
inoremap [<cr> [<cr>]<C-O>O
inoremap [<tab> []<esc>i
inoremap (<cr> (<cr>)<C-O>O
inoremap (<tab> ()<esc>i
inoremap "<tab> ""<esc>i
inoremap '<tab> ''<esc>i
inoremap `<tab> ``<esc>i
imap <expr> <C-\> copilot#Accept("\<cr>")
imap <C-J> <Plug>(copilot-accept-word)
imap <C-L><C-]> <Plug>(copilot-dismiss)
imap <C-L><C-K> <Plug>(copilot-next)
imap <C-L><C-J> <Plug>(copilot-previous)
imap <C-L><C-L> <Plug>(copilot-accept-line)
inoremap <C-S> <cr><esc>kA
inoremap <C-Space> <C-X><C-O>
inoremap <c-bs> <bs>

cnoremap <C-H> <C-R>=expand("%:p:h")<cr>/
cnoremap <C-L> <C-R>=getline(".")<cr>
cnoremap <C-space> .*
cnoremap <A-9> \(
cnoremap <A-0> \)
cnoremap <A-space> \<space>
cnoremap <A-.> \.
cnoremap <A-/> \/
cnoremap <A-"> \"
cnoremap <A-'> \'

tmap <C-a> <C-\><C-n><C-a>

onoremap <silent> il :normal vil<CR>
onoremap <silent> al :normal val<CR>
onoremap <silent> iq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
onoremap <silent> aq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
onoremap <silent> iQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
onoremap <silent> aQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
	\setlocal iskeyword-=.,=,:<cr>

function! NavDirFiles(count) abort
	let curfile = expand("%:p")
	let curdir = expand("%:p:h")
	let files = systemlist("find " .. curdir .. "/ -type f -maxdepth 1")
	let filelen = len(files)
	let curidx = index(files, curfile)
	let newidx = float2nr(fmod(curidx + a:count, filelen))
	if newidx < 0
		let newidx += filelen
	endif
	exe "e " .. files[newidx]
endfunction

" Allows wrapping for nvim ]a and [a arglist mappings
function! NavArglist(count)
	let arglen = argc()
	if arglen == 0
		return
	endif
	let next = fmod(argidx() + a:count, arglen)
	if next < 0
		let next += arglen
	endif
	exe float2nr(next + 1) .. 'argu'
endfunction

""""""""""""
" Commands "
""""""""""""

command! Bonly %bd|e#|bd#|norm `"
command! Bdelete e#|bd#
command! Bactive call s:CloseHiddenBuffers()
command! -nargs=? Gcompbranch let g:compare_branch = <q-args>
command! Grediff windo diffthis\|windo norm zM
command! -count=1 Cgnext cclose<bar>wincmd l<bar>only<bar><count>cnext<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Cgprevious cclose<bar>wincmd l<bar>only<bar><count>cprev<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Cglast cclose<bar>wincmd l<bar>only<bar>clast<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Cgfirst cclose<bar>wincmd l<bar>only<bar>cfirst<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Lgnext cclose<bar>wincmd l<bar>only<bar><count>lnext<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Lgprevious cclose<bar>wincmd l<bar>only<bar><count>lprev<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Lglast cclose<bar>wincmd l<bar>only<bar>llast<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Lgfirst cclose<bar>wincmd l<bar>only<bar>lfirst<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args>
command! PackInstall call PackInit() | call minpac#update(keys(filter(copy(minpac#pluglist), 
	\{-> !isdirectory(v:val.dir . '/.git')})))
command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")
command! PackStatus packadd minpac | call minpac#status()
command! -nargs=* Pgrep grep <args> %:p:h
command! -nargs=* Plgrep lgrep <args> %:p:h
command! -bang Wfmt let g:format_on_save = <bang>1 | w | let g:format_on_save = <bang>0
command! -bang Wafmt let g:format_on_save = <bang>1 | wa | let g:format_on_save = <bang>0

function! s:CloseHiddenBuffers()
	let open_buffers = []
	for i in range(tabpagenr('$'))
		call extend(open_buffers, tabpagebuflist(i + 1))
	endfor
	for num in range(1, bufnr("$") + 1)
		if buflisted(num) && index(open_buffers, num) == -1
			exec "bdelete ".num
		endif
	endfor
endfunction

""""""""""""""""
" Autocommands "
""""""""""""""""

augroup vimrc
	autocmd!
augroup END

autocmd vimrc WinEnter * if &buftype ==# 'terminal' && mode() !=# 't' | startinsert | endif
autocmd vimrc BufEnter * let b:workspace_folder = getcwd() "Copilot
autocmd vimrc VimLeave * if !empty(v:this_session) | exe 
	\'call writefile(["set background=" .. &background, "colorscheme " ..
	\g:colors_name], v:this_session, "a")' | endif
autocmd vimrc VimLeave * if !empty(v:this_session) | exe "CopilotChatSave " ..
	\slice(substitute(getcwd(-1, -1), '/', '-', 'g'), 1) | endif
autocmd vimrc VimEnter * if !empty(v:this_session) | exe "CopilotChatLoad " ..
	\slice(substitute(getcwd(-1, -1), '/', '-', 'g'), 1) | endif
autocmd vimrc ColorSchemePre * hi clear
autocmd vimrc BufWritePre * if g:format_on_save | call FormatBuf() | endif
autocmd vimrc OptionSet formatprg call s:SetFormatMaps()
autocmd vimrc OptionSet shiftwidth call s:SetSpaceIndentGuides(v:option_new)
autocmd vimrc BufWinEnter * call s:SetSpaceIndentGuides(&l:shiftwidth)
autocmd vimrc FileType * call s:SetFormatMaps()
autocmd vimrc FileType * set include=
autocmd vimrc BufRead * call s:SetJumpScopeMaps()
"autocmd vimrc BufRead * set iskeyword+=-
autocmd vimrc BufRead,BufNewFile *.jinja2 set filetype=jinja2
autocmd vimrc TabNewEntered * argl|%argd

function! s:SetSpaceIndentGuides(sw) abort
	let indent = a:sw
	if indent == 0
		let indent = &tabstop
	endif
	if &l:listchars == ""
		let &l:listchars = &listchars
	endif
	let listchars = substitute(&listchars, 'leadmultispace:.\{-},', '', 'g')
	let newlead = "\┆"
	for i in range(indent - 1)
		let newlead .= "\ "
	endfor
	let newlistchars = "leadmultispace:" .. newlead .. "," .. listchars
	let &l:listchars = newlistchars
endfunction

function! s:SetFormatMaps() abort
	if &formatprg == ""
		return
	endif
	nnoremap <buffer> <F3> <cmd>call FormatBuf(v:true)<cr>
endfunction

function! FormatBuf(preserve_undo=0) abort
	if &formatprg == ""
		return
	endif
	let l:view = winsaveview()
	if !a:preserve_undo
		" Best we can do to prevent mangling the undo history after formatting
		sil! undojoin | norm gggqG
	else
		norm gggqG
	endif
	call winrestview(l:view)
endfunction

function! s:SetJumpScopeMaps() abort
	if &ft == "c" || &ft == "cpp" || &ft == "python" || &ft == "markdown"
		return
	endif
	noremap <silent> <buffer> ]1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'W')\|endfor<cr>
	noremap <silent> <buffer> [1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'bW')\|endfor<cr>
endfunction	

