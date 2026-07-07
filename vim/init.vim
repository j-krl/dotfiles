lua require('config')

"""""""""""
" Options "
"""""""""""

let g:maplocalleader = "_"
set relativenumber
set number
set tabstop=4
set shiftwidth=4
set termguicolors
set smartindent
set wildmenu
set wildmode=noselect:longest:lastused:full,full
set cursorline
set undofile
set nofixeol
set colorcolumn=80,88,120
set signcolumn=yes
set completeopt=menuone,popup
set foldopen-=search
set mouse=a
set list
set exrc
set noswapfile
set listchars=tab:\│\ ,precedes:>,extends:<
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,**/.git/*,**/build/*,**/__pycache__/*
set wildoptions=pum,tagfile
set wildcharm=<tab>
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git/*'
set spellcapcheck=
set foldmethod=indent
set foldlevel=100
set foldlevelstart=101
set fillchars=diff:\
set statusline=%<%f\ \ %<%{CwdStatusline()}\ \ %{FugitiveStatusline()}\ %h%m%r%=[%n]\ %-13a%-13(%l,%c%V%)\ %P

function! CwdStatusline() abort
	let cwd = fnamemodify(getcwd(), ":t")
	return '(cwd: ' .. cwd .. ')'
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
let g:copilot_filetypes = {'markdown': v:false}
let g:format_on_save = 1
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
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
noremap <space>p "+p
noremap <space>P "+P
noremap <space>y "+y
noremap <space>Y "+Y
nnoremap <silent> - :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" :
	\""<cr>:Explore<cr>
nnoremap <space>- :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>
	\exe "Explore " .. getcwd()<cr>
nnoremap gs a<cr><esc>k$
nnoremap gS i<cr><esc>k$
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"
	\<cr><cr>
nnoremap yr+ :let @+ = @0<cr>
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
nnoremap ]f <cmd>call NavDirFiles(v:count1)<cr>
nnoremap [f <cmd>call NavDirFiles(v:count1 * -1)<cr>
nnoremap <bs> <C-^>
nnoremap <F2> <C-L><cmd>args<cr>
nnoremap <F3> <cmd>FmtBuf<cr>
" Join lines like 'J' without space between
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. 
	\(v:count < 2 ? v:count - 1: v:count - 2) .. 's/\n\s*//g<cr>`l'
nnoremap <expr> <C-W>C "<cmd>" .. repeat("tabcl\|", v:count1) .. "<cr>"
nnoremap <C-W>N <cmd>tabnew\|Explore<cr>
nnoremap <C-W>S <cmd>tab split<cr>
nnoremap <C-W>Z <C-W>_<C-W>\|
nnoremap <expr> <A-j> ":<C-U>m +" .. v:count1 .. " <cr>"
nnoremap <expr> <A-k> ":<C-U>m -" .. (v:count1 + 1) .. " <cr>"
nnoremap <expr> <space>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <space>S v:count >= 1 ? ":s/<C-R><C-W>/" : ":%s/<C-R><C-W>/"
nnoremap <expr> <leader><leader> "<cmd>call EditLastUsedBuf(" .. v:count1 ..
	\")<cr>"
nnoremap <leader>- mZ<cmd>FzfLua resume<cr>
"nnoremap <leader>.f :<C-U>find <C-R>=expand("%:.:h")<cr>/<tab>
nnoremap <leader>.f mZ<cmd>lua require("fzf-lua").files({ cwd =
	\vim.fn.expand("%:h:.") })<cr>
nnoremap <leader>@ :%diffget LOCAL<tab><cr>
nnoremap <leader># :%diffget REMOTE<tab><cr>
nnoremap <leader>.g :<C-U>grep '' %:p:h<tab><S-left><left><left>
nnoremap <leader>.G :<C-U>grep '' %:p:h<tab><S-left><left><left><C-R><C-W><cr>
nnoremap <leader>.z mZ<cmd>lua require("fzf-lua").live_grep_native({ cwd =
	\vim.fn.expand("%:h:.") })<cr>
nnoremap <leader>.Z mZ<cmd>lua require("fzf-lua").grep_cword({ cwd =
	\vim.fn.expand("%:h:.") })<cr>
nnoremap <leader>a <cmd>CodeCompanionChat Toggle<cr>
nnoremap <leader>A <cmd>CodeCompanionChat<cr>
nnoremap <leader>b mZ<cmd>FzfLua buffers<cr>
nnoremap <leader>B mZ<cmd>FzfLua lines<cr>
nnoremap <leader>c <cmd>cwindow<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <leader>d mZ<cmd>FzfLua cd_parent<cr>
nnoremap <leader>D mZ<cmd>FzfLua git_dfiles<cr>
nnoremap <leader>f mZ<cmd>FzfLua files<cr>
nnoremap <leader>F mZ<cmd>FzfLua args<cr>
nnoremap <leader>g :<C-U>grep ''<left>
nnoremap <leader>G :<C-U>grep ''<left><C-R><C-W><cr>
nnoremap <leader>pf mZ<cmd>lua require("fzf-lua").files({ cwd =
	\vim.fn.getcwd() .. "/.." })<cr>
nnoremap <leader>pg :<C-U>grep '' ..<left><left><left><left>
nnoremap <leader>pG :<C-U>grep '' ..<left><left><left><left><C-R><C-W><cr>
nnoremap <leader>pz mZ<cmd>lua require("fzf-lua").live_grep_native({ cwd =
	\vim.fn.getcwd() .. "/.." })<cr>
nnoremap <leader>pZ mZ<cmd>lua require("fzf-lua").grep_cword({ cwd =
	\vim.fn.getcwd() .. "/.." })<cr>
nnoremap <leader>o mZ<cmd>FzfLua oldfiles<cr>
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <leader>r mZ<cmd>FzfLua lsp_references<cr>
nnoremap <leader>R mZ<cmd>FzfLua git_branches<cr>
nnoremap <leader>s mZ<cmd>FzfLua lsp_live_workspace_symbols<cr>
nnoremap <leader>z mZ<cmd>FzfLua live_grep_native<cr>
nnoremap <leader>Z mZ<cmd>FzfLua grep_cword<cr>

xnoremap <leader>a <cmd>CodeCompanionChat<cr>
xnoremap <silent> il g_o^
xnoremap <silent> al $o0
xnoremap <expr> <A-j> ":m '>+" .. v:count1 .. "<CR>gv=gv"
xnoremap <expr> <A-k> ":m '<-" .. (v:count1 + 1) .. "<CR>gv=gv"

" Hungry delete
inoremap <silent> <expr> <bs> !search('\S','nbW',line('.')) ? 
	\(col('.') != 1 ? "\<C-U>" : "") .. "\<bs>" : "\<bs>"
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
imap <expr> <C-\> copilot#Accept("\<cr>")
imap <C-J> <Plug>(copilot-accept-word)
imap <C-L> <Plug>(copilot-accept-line)
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
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>
cabbrev Gac Git ac -m
cabbrev Gacp Git acp
cabbrev Gac Git ac
cabbrev Gb Git blame
cabbrev Gbr GBrowse
cabbrev Gcb Git checkout -b
cabbrev Gcd Git dcheckout
cabbrev Gco Git checkout
cabbrev Gd Git diff
cabbrev Gl Git log
cabbrev Gpl Git pull
cabbrev Gpr Git pr
cabbrev Gps Git push
cabbrev Gs Git show
cabbrev fz FzfLua
cabbrev e. edit ~/dotfiles
cabbrev ez edit ~/.zshrc
cabbrev sov source $MYVIMRC

onoremap <silent> il :normal vil<CR>
onoremap <silent> al :normal val<CR>

function! EditLastUsedBuf(num) abort
	let l = getbufinfo({"buflisted": 1})
		\->filter({_, d -> !empty(d.name) && d.bufnr != bufnr("%")})
		\->sort({d1, d2 -> d2.lastused - d1.lastused})
	if len(l) < a:num
		echoerr "Not enough buffers"
		return
	endif
	exe 'buffer ' .. l[a:num - 1].bufnr
endfunc

function! NavDirFiles(count) abort
	let curfile = expand("%:p")
	let curdir = expand("%:p:h")
	let files = systemlist("find " .. curdir .. "/ -type f -maxdepth 1 | sort")
	let filelen = len(files)
	let curidx = index(files, curfile)
	let newidx = float2nr(fmod(curidx + a:count, filelen))
	if newidx < 0
		let newidx += filelen
	endif
	exe "e " .. fnameescape(files[newidx])
endfunction

function! NavSiblingDirs(count) abort
	let curdir = expand("%:p:h")
	let parentdir = expand("%:p:h:h")
	let dirs = systemlist("find " .. parentdir ..
		\" -type d -maxdepth 1 -mindepth 1 | sort")
	let dirslen = len(dirs)
	let curidx = index(dirs, curdir)
	let newidx = float2nr(fmod(curidx + a:count, dirslen))
	if newidx < 0
		let newidx += dirslen
	endif
	exe "e " .. dirs[newidx]
endfunction

""""""""""""
" Commands "
""""""""""""

command! Bonly %bd|e#|bd#|norm `"
command! -nargs=+ Cfuzzy call s:FuzzyFilterQf(<f-args>)
command! Clen echo len(getqflist())
command! CodeCompanionCopilotModelKeys lua print(vim.inspect(vim.tbl_keys(require("codecompanion.adapters").resolve("copilot").schema.model.choices())))
command! -nargs=? -complete=dir Explore Dirvish <args>
command! Llen echo len(getloclist(winnr()))
command! Rediff windo diffthis\|windo norm zM
command! Scratch new|set buftype=nofile noswapfile bufhidden=hide
command! -nargs=* -complete=dir_in_path Tree exe "Scratch" | exe "r !tree " ..
	\<q-args>
command! W Wfmt!
command! Ybranch let @+ = system("git branch --show-current")
command! Ycwd let @+ = getcwd()
command! -bang Ypath exe "let @+ = expand('%:" .. (<bang>0 ? "p" : ".") .. ":h" .. "')"
command! -bang Yfile exe "let @+ = expand('%:" .. (<bang>0 ? "p" : ".") .. "')"

function! s:FuzzyFilterQf(...) abort
	let matchstr = join(a:000, " ")
	let filtered_items = matchfuzzy(getqflist(), matchstr, {'key': 'text'})
	call setqflist([], " ", {"nr": "$", "title": ":Cfuzzy /" .. matchstr .. 
		\"/", "items": filtered_items})
endfunction

""""""""""""""""
" Autocommands "
""""""""""""""""

augroup vimrc
	autocmd!
augroup END

autocmd vimrc QuickFixCmdPost [^l]* exe "norm mG"|cwindow
autocmd vimrc QuickFixCmdPost l* exe "norm mG"|lwindow
autocmd vimrc BufRead * call s:SetJumpScopeMaps()
autocmd vimrc BufRead,BufNewFile *.jinja2 set filetype=jinja2
autocmd vimrc BufRead,BufNewFile yarn.lock set filetype=text
autocmd vimrc FileType * lua pcall(vim.treesitter.start)

function! s:SetJumpScopeMaps() abort
	if &ft == "c" || &ft == "cpp" || &ft == "python" || &ft == "markdown"
		return
	endif
	noremap <silent> <buffer> ]1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'W')\|endfor<cr>
	noremap <silent> <buffer> [1 m'<cmd>for i in range(v:count1)\|
			\call search('^[^ \t}#/\")\-]', 'bW')\|endfor<cr>
endfunction	

"""""""""
" Final "
"""""""""

packadd cfilter
" Custom plugins in pack/internal/opt/
packadd AfterColors.vim
packadd format
packadd dynamic-indent-guides
packadd gh-pull-requests
packadd arglist-plus

" Environment-specific settings
let g:vimenv = fnamemodify($MYVIMRC, ':h') .. "/.vimenv"
if filereadable(g:vimenv)
  exe 'source ' g:vimenv
endif

