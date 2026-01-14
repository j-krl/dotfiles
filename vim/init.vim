function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('airblade/vim-rooter')
	call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
	call minpac#add('ibhagwan/fzf-lua')
	call minpac#add('jeetsukumaran/vim-indentwise')
	call minpac#add('justinmk/vim-dirvish')
	call minpac#add('kylechui/nvim-surround')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-rhubarb')
	call minpac#add('tpope/vim-sleuth')
	call minpac#add('unblevable/quick-scope')
	" AI
	call minpac#add('github/copilot.vim')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('olimorris/codecompanion.nvim')
	" Treesitter dependent
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
set statusline=%<%f\ \ %{FugitiveStatusline()}\ %h%m%r%=[%n]\ %-13a%-13(%l,%c%V%)\ %P
let &packpath = stdpath("data") .. "/site," .. substitute(&packpath, 
	\stdpath("data") .. "/site,", "", "g")

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
let g:qf_cache_dir = expand("~") .. "/.cache/vim/"
let g:format_on_save = 1
let g:compare_branch = "master"
let g:rooter_change_directory_for_non_project_files = 'current'

""""""""""""
" Mappings "
""""""""""""

noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap <silent> - :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" :
	\""<cr>:Explore<cr>
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"
	\<cr><cr>
nnoremap yr+ :let @+ = @0<cr>
nnoremap yrc :let @+ = system("git branch --show-current")<cr>
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
nnoremap ]f <cmd>call NavDirFiles(v:count1)<cr>
nnoremap [f <cmd>call NavDirFiles(v:count1 * -1)<cr>
nnoremap <bs> <C-^>
nnoremap <F2> <C-L><cmd>args<cr>
nnoremap <F3> <cmd>FmtBuf<cr>
nnoremap <F9> <cmd>CodeCompanionChat toggle<cr>
" Join lines like 'J' without space between
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. 
	\(v:count < 2 ? v:count - 1: v:count - 2) .. 's/\n\s*//g<cr>`l'
nnoremap <expr> <C-W>C "<cmd>" .. repeat("tabcl\|", v:count1) .. "<cr>"
nnoremap <C-W>N <cmd>tabnew\|Explore<cr>
nnoremap <C-W>Z <C-W>_<C-W>\|
nnoremap <expr> <A-j> ":<C-U>m +" .. v:count1 .. " <cr>"
nnoremap <expr> <A-k> ":<C-U>m -" .. (v:count1 + 1) .. " <cr>"
" Open file explorer at cwd
nnoremap <space>- :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>
	\exe "Explore " .. getcwd()<cr>
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
noremap <space>Y "+Y
nnoremap <space>s a<cr><esc>k$
nnoremap <space>S i<cr><esc>k$
nnoremap <leader>- mZ<cmd>FzfLua resume<cr>
nnoremap <leader>b :<C-U>b<space><tab>
nnoremap <leader>c <cmd>cwindow<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <leader>f :<C-U>find<space>
nnoremap <leader>F :<C-U>find <C-R>=expand("%:.:h")<cr>/<tab>
nnoremap <leader>g :<C-U>grep ''<left>
nnoremap <leader>G :<C-U>grep '' %:p:h<tab><S-left><left><left>
nnoremap <leader>l <cmd>lwindow<cr>
nnoremap <leader>L <cmd>lclose<cr>
nnoremap <leader>o <cmd>browse oldfiles<cr>
nnoremap <leader>O <cmd>FzfLua oldfiles<cr>
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <expr> <leader>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <leader>S v:count >= 1 ? ":s/<C-R><C-W>/" : ":%s/<C-R><C-W>/"
nnoremap <leader>x <cmd>xa<cr>
nnoremap <leader>z mZ<cmd>FzfLua live_grep_native<cr>
nnoremap <leader>Z mZ<cmd>lua require("fzf-lua").live_grep_native({ cwd = vim.fn.expand("%:h:.") })<cr>

xnoremap <F9> <cmd>CodeCompanionChat Add<cr>
xnoremap <silent> il g_o^
xnoremap <silent> al $o0
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

""""""""""""
" Commands "
""""""""""""

command! Bonly %bd|e#|bd#|norm `"
command! Bdelete e#|bd#
command! Bactive call s:CloseHiddenBuffers()
command! -nargs=+ Cfuzzy call s:FuzzyFilterQf(<f-args>)
command! Clen echo len(getqflist())
command! ClipBranch let @+ = system("git branch --show-current")
command! -nargs=? -bang ClipPath exe "let @+ = expand('%:p" .. 
	\(<q-args> != "" ? ":" : "") .. <q-args> .. (<bang>0 ? ":h" : "") .. "')"
command! ClipCwd let @+ = getcwd(-1)
command! Gcurr !git branch --show-current
command! -count=1 Gnextdiff ccl|wincmd l|only|<count>cnext|cw|
	\wincmd p|exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Gprevdiff ccl|wincmd l|only|<count>cprev|cw|wincmd p|
	\exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Glastdiff ccl|wincmd l|only|clast|cw|wincmd p|
	\exe "Gvdiffsplit " .. g:compare_branch
command! -count=1 Gfirstdiff ccl|wincmd l|only|cfirst|cw|wincmd p|
	\exe "Gvdiffsplit " .. g:compare_branch
command! -nargs=? Gcompbranch let g:compare_branch = <q-args>
command! Grediff windo diffthis\|windo norm zM
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split |
	\silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore belowright vsplit |
	\silent Dirvish <args>
command! Llen echo len(getloclist(winnr()))
command! PackInstall call PackInit() 
	\| call minpac#update(keys(filter(copy(minpac#pluglist), 
	\{-> !isdirectory(v:val.dir . '/.git')})))
command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() 
	\| echo join(sort(keys(minpac#getpluglist())), "\n")
command! PackStatus packadd minpac | call minpac#status()
command! Scratch new|set buftype=nofile|set noswapfile|set bufhidden=hide
command! Todo exe "pedit +1 " .. getcwd(-1, -1) .. "/TODO.md"|wincmd p"
command! -nargs=* -complete=dir_in_path Tree exe "Scratch" | exe "r !tree " .. <q-args>

function! s:FuzzyFilterQf(...) abort
	let matchstr = join(a:000, " ")
	let filtered_items = matchfuzzy(getqflist(), matchstr, {'key': 'text'})
	call setqflist([], " ", {"nr": "$", "title": ":Cfuzzy /" .. matchstr .. 
		\"/", "items": filtered_items})
endfunction

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

autocmd vimrc QuickFixCmdPost [^l]* exe "norm mG"|cwindow
autocmd vimrc QuickFixCmdPost l* exe "norm mG"|lwindow
autocmd vimrc TabNewEntered * argl|%argd
autocmd vimrc WinEnter * if &buftype ==# 'terminal' && mode() !=# 't' |
	\startinsert | endif
autocmd vimrc BufRead * call s:SetJumpScopeMaps()
autocmd vimrc BufRead,BufNewFile *.jinja2 set filetype=jinja2

function! s:SetJumpScopeMaps() abort
	if &ft == "c" || &ft == "cpp" || &ft == "python" || &ft == "markdown"
		return
	endif
	noremap <silent> <buffer> ]1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'W')\|endfor<cr>
	noremap <silent> <buffer> [1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'bW')\|endfor<cr>
endfunction	

