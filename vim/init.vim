function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('unblevable/quick-scope')
	call minpac#add('christoomey/vim-tmux-navigator')
	call minpac#add('jeetsukumaran/vim-indentwise')
	call minpac#add('NMAC427/guess-indent.nvim')
	call minpac#add('jpalardy/vim-slime')
	call minpac#add('gcmt/taboo.vim')
	call minpac#add('justinmk/vim-dirvish')
	call minpac#add('kylechui/nvim-surround')
	call minpac#add('tpope/vim-obsession')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-rhubarb')
	call minpac#add('github/copilot.vim')
	call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('junegunn/fzf')
	call minpac#add('junegunn/fzf.vim')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
	call minpac#add('nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'})
	call minpac#add('nvim-treesitter/nvim-treesitter-textobjects', {'branch': 'master'})
	call minpac#add('nvim-treesitter/nvim-treesitter-context')
	call minpac#add('HiPhish/rainbow-delimiters.nvim')
	call minpac#add('Wansmer/treesj')
endfunction
packadd cfilter

exe "source " .. stdpath("config") .. "/vimrc"

"""""""""""
" Options "
"""""""""""

set termguicolors
set wildmode=noselect:longest:lastused,full
set undofile
set nofixeol
" Required for taboo to persist names in sessions
set sessionoptions+=globals
set hidden
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
let g:maplocalleader = "_"
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
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom-left}"}
let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1
let g:qf_session_auto_cache = 1
let g:qf_session_auto_load = 1
let g:qf_cache_dir = expand("~") .. "/.cache/vim/"
let g:format_on_save = 1
let g:compare_branch = "master"
let g:fzf_layout = { 'down': '30%' }
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
let $BAT_THEME = "ansi"

"""""""""""""""""""""""
" Mappings & Commands "
"""""""""""""""""""""""

""" Text manipulation """
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap <expr> <leader>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <leader>S v:count >= 1 ? ":s/<C-R><C-W>/" : ":%s/<C-R><C-W>/"
nnoremap <space>s a<cr><esc>k$
nnoremap <space>S i<cr><esc>k$
" Join lines like 'J' without space between
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. 
	\(v:count < 2 ? v:count - 1: v:count - 2) .. 's/\n\s*//g<cr>`l'
" Move line or selection of lines [count] lines up or down
nnoremap <expr> <A-j> ":<C-U>m +" .. v:count1 .. " <cr>"
nnoremap <expr> <A-k> ":<C-U>m -" .. (v:count1 + 1) .. " <cr>"
vnoremap <expr> <A-j> ":m '>+" .. v:count1 .. "<CR>gv=gv"
vnoremap <expr> <A-k> ":m '<-" .. (v:count1 + 1) .. "<CR>gv=gv"
inoremap <C-S> <cr><esc>kA
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
inoremap {<tab> {}<esc>i
inoremap [<tab> []<esc>i
inoremap (<tab> ()<esc>i
nmap ]o ]<space>j
nmap [o [<space>k
" Hungry delete
inoremap <silent> <expr> <bs> !search('\S','nbW',line('.')) ? 
	\(col('.') != 1 ? "\<C-U>" : "") .. "\<bs>" : "\<bs>"
inoremap <c-bs> <bs>

""" File navigation """
noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap <backspace> <C-^>
" go to definition (not in qflist)
nnoremap <expr> <cr> &buftype ==# 'quickfix' \|\| &buftype ==# 'nofile' ? "\<cr>" : "\<C-]>"
nnoremap <leader>b :<C-U>b<space><tab>
nnoremap <leader>e :<C-U>edit<space>
nnoremap <leader>E :<C-U>edit <C-H>
nnoremap <leader>f :<C-U>find<space>
nnoremap <leader>F :<C-U>find <C-R>=expand("%:.:h")<cr>/<tab>
nnoremap <leader>gg :<C-U>grep ''<left>
nnoremap <leader>G :<C-U>grep <C-R><C-W><cr>
nnoremap <leader>22 :<C-U>lgrep ''<left>
nnoremap <leader>@ :<C-U>lgrep <C-R><C-W><cr>
nnoremap <leader>gz :<C-U>Zgrep<space>
nnoremap <leader>gZ :<C-U>Fzfgrep<space>
nnoremap <leader>gp :<C-U>Pgrep ''<left>
nnoremap <leader>gP :<C-U>Pgrep <C-R><C-W><cr>
nnoremap <leader>2p :<C-U>Plgrep ''<left>
nnoremap <leader>2P :<C-U>Plgrep <C-R><C-W><cr>
nnoremap <leader>2v ml:<C-U>lvim <C-R><C-W> %\|lwindow<cr><cr>
nnoremap <leader>pp :<C-U>Prjgoto<space><tab>
nnoremap <leader>pO <cmd>Prjonly<cr>
nnoremap ]f <cmd>call NavDirFiles(v:count1)<cr>
nnoremap [f <cmd>call NavDirFiles(v:count1 * -1)<cr>
command! Bonly %bd|e#|bd#|norm `"
command! Bdelete e#|bd#
command! Bactive call s:CloseHiddenBuffers()
command! -nargs=+ -complete=file_in_path Fzfgrep call FzfGrep(<f-args>)
command! -nargs=+ -complete=file_in_path Zgrep call FuzzyFilterGrep(<f-args>)
command! -nargs=* Pgrep grep <args> %:p:h
command! -nargs=* Plgrep lgrep <args> %:p:h

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

""" Windows """
nnoremap <C-W>Z <C-W>_<C-W>\|
" close opposite split
nnoremap <C-W>X <C-W>x<C-W>c
" go to definition in vertical split
nmap <C-W>[ <C-W>v<C-]>
nmap <C-W>] <C-W>]<C-W>r
nmap <C-W>V <C-W>o<C-W>v
" Navigate windows normally in terminal mode
tmap <C-a> <C-\><C-n><C-a>
noremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
noremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
noremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
noremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>

""" Slime """
xmap <leader>3 <Plug>SlimeRegionSend
nmap <leader>3 <Plug>SlimeParagraphSend

""" Marks """
nnoremap <leader>mm <cmd>marks ABCDEFHIJKLMNOPQRSTUVWXYZ<cr>
nnoremap <leader>md :<C-U>delm<space>
nnoremap <leader>mD <cmd>delm ABCDEFHIJKLMNOPQRSTUVWXYZ<bar>echo "global marks cleared"<cr>

""" File explorer """
" Override calls to netrw with Dirvish
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args>
nnoremap <silent> - :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>:Explore<cr>
" Open file explorer at cwd
nnoremap <space>- :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>
	\exe "Explore " .. getcwd()<cr>

""" FZF """
nnoremap <leader>zz <cmd>RG<cr>
nnoremap <leader>zf <cmd>Files<cr>
nnoremap <leader>zl <cmd>BLines<cr>
nnoremap <leader>zt <cmd>Tags<cr>
nnoremap <leader>zo <cmd>History<cr>
nnoremap <leader>zc <cmd>History:<cr>
nnoremap <leader>z/ <cmd>History/<cr>
nnoremap <leader>zg <cmd>Commits<cr>
nnoremap <leader>zh <cmd>Helptags<cr>

""" Quickfix/Location list """
nnoremap <leader>ll <cmd>lwindow<cr>
nnoremap <leader>L <cmd>lclose<cr>
nnoremap <leader>cc <cmd>cwindow<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <expr> <leader>ch "<cmd>" .. (v:count > 0 ? v:count : "")
	\.. "chistory" .. (v:count > 0 ? "\|cw" : "") .. "<cr>"
nnoremap <expr> <leader>lh "<cmd>" .. (v:count > 0 ? v:count : "")
	\.. "lhistory" .. (v:count > 0 ? "\|cw" : "") .. "<cr>"
nnoremap <leader>cl <cmd>clist<cr>
nnoremap <leader>lc <cmd>llist<cr>
nnoremap <leader>c<leader> <cmd>exe (v:count > 0 ? v:count : ".") .. "cc"<cr>
nnoremap <leader>l<leader> <cmd>exe (v:count > 0 ? v:count : ".") .. "ll"<cr>
nnoremap <leader>cL <cmd>echo len(getqflist())<cr>
nnoremap <leader>lL <cmd>echo len(getloclist(winnr()))<cr>
nnoremap <expr> <silent> <leader>cd "<cmd>" .. v:count1 .. "Cditem<cr>"
nnoremap <expr> <silent> <leader>ld "<cmd>" .. v:count1 .. "Lditem<cr>"
nnoremap <leader>cf :<C-U>Cfilter<space>
nnoremap <leader>cF :<C-U>Cfilter!<space>
nnoremap <leader>lf :<C-U>Lfilter<space>
nnoremap <leader>lF :<C-U>Lfilter!<space>
nnoremap <leader>cz :<C-U>Cfuzzy<space>
nnoremap <expr> <leader>cD "<cmd>Chdelete " .. v:count .. "<cr>"
nnoremap <leader>cn <cmd>Clist<cr>
nnoremap <leader>cr :<C-U>Cdelete<space><tab>
nnoremap <leader>cs :<C-U>Csave<space>
nnoremap <leader>co :<C-U>Cload<space><tab>

""" Formatting """
nnoremap <leader>W <cmd>Wfmt!<cr>
nnoremap <leader>wA <cmd>Wfmtall!<cr>
command! -bang Wfmt let g:format_on_save = <bang>1 | w | let g:format_on_save = <bang>0
command! -bang Wfmtall let g:format_on_save = <bang>1 | wa | let g:format_on_save = <bang>0

""" Block paste """
nnoremap <A-p>= <cmd>put +<cr>
nnoremap <A-P>= <cmd>put! +<cr>
nnoremap <A-p>0 <cmd>put 0<cr>
nnoremap <A-P>0 <cmd>put! 0<cr>
nnoremap <A-p>" <cmd>put \"<cr>
nnoremap <A-P>" <cmd>put! \"<cr>

""" Tabs """
nnoremap <leader><leader> gt
nnoremap <expr> ]w "<cmd>norm " .. repeat("gt", v:count1) .. "<cr>"
nnoremap [w gT
nnoremap [W <cmd>tabfirst<cr>
nnoremap ]W <cmd>tablast<cr>
nnoremap <C-W>N <cmd>tabnew\|Explore<cr>
nnoremap <C-W>D <cmd>tcd %<cr>
nnoremap <expr> <C-W>C "<cmd>" .. repeat("tabcl\|", v:count1) .. "<cr>"
nnoremap <C-W><tab> g<tab>
" Split to next tab with no [count], otherwise split to [count]th index. Like
" `<C-W>T`, but don't close the original window
nnoremap <C-W>S :<C-U>exe (v:count > 0 ? v:count - 1 : "") .. "tab split"<cr>
" Move tab to the end without a [count] otherwise move to [count]th index
nnoremap <C-W>M :<C-U>exe (v:count > 0 ? 
	\(tabpagenr() < v:count ? v:count : (v:count - 1)) : "$") .. "tabmove"<cr>

""" Fugitive/Git """
command -nargs=? Gcompbranch let g:compare_branch = <q-args>
" Git status summary
nnoremap <space>gg :<C-U>G<cr>
nnoremap <space>gb :<C-U>Git blame<cr>
nnoremap <space>gD :<C-U>Git diff<cr>
nnoremap <space>gB :<C-U>GBrowse<cr>
nnoremap <space>gl :<C-U>Git log<cr>
" Switch to the working directory version of the current file
nnoremap <space>ge :<C-U>Gedit<cr>
nnoremap <space>gE :<C-U>Gedit :%<left><left>
nnoremap <space>gw :<C-U>windo diffthis\|windo norm zM<cr>
nnoremap <space>gv :<C-U>Gvdiffsplit<space>
nnoremap <space>gV :<C-U>tab Gvdiffsplit<space>
" Load all past revisions of the current file into the qflist
nnoremap <space>g0 :<C-U>0Gclog<cr>
nnoremap <space>gt :<C-U>Git difftool<space>
nnoremap <space>gT :<C-U>Git difftool -y<space>
nnoremap <space>ga <cmd>!git add %<cr>
nnoremap <space>gA <cmd>!git add .<cr>
" qf/loc list split navigation
nmap ]vv <cmd>cclose<bar>wincmd l<bar>only<bar>exe v:count1 .. "cnext"<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap [vv <cmd>cclose<bar>wincmd l<bar>only<bar>exe v:count1 .. "cprev"<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap ]VV <cmd>cclose<bar>wincmd l<bar>only<bar>clast<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap [VV <cmd>cclose<bar>wincmd l<bar>only<bar>cfirst<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap ]vl <cmd>cclose<bar>wincmd l<bar>only<bar>exe v:count1 .. "lnext"<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap [vl <cmd>cclose<bar>wincmd l<bar>only<bar>exe v:count1 .. "lprev"<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap ]VL <cmd>cclose<bar>wincmd l<bar>only<bar>llast<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>
nmap [VL <cmd>cclose<bar>wincmd l<bar>only<bar>lfirst<bar>cwindow<bar>wincmd p<bar>exe "Gvdiffsplit " .. g:compare_branch<cr>

""" Arglist """
nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr><esc>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
nnoremap <F2> <C-L><cmd>args<cr>
nnoremap <leader>aa <cmd>$arge %<bar>argded<bar>args<cr>
nnoremap <leader>ap <cmd>0arge %<bar>argded<bar>args<cr>
nnoremap <leader>ad <cmd>argd %<bar>args<cr>
nnoremap <leader>ac <cmd>%argd<cr><C-L><cmd>echo "arglist cleared"<cr>
nnoremap <leader>al <cmd>argl\|%argd\|echo "local arglist created"<cr>
nnoremap <leader>af :<C-U>arga `fd --hidden --type f -E '.git' --full-path ''`<left><left>
" Go to arglist file at index [count]
nnoremap <expr> <space><space> ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"

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


""" Copilot
imap <expr> <C-\> copilot#Accept("\<cr>")
imap <C-J> <Plug>(copilot-accept-word)
imap <C-L><C-]> <Plug>(copilot-dismiss)
imap <C-L><C-K> <Plug>(copilot-next)
imap <C-L><C-J> <Plug>(copilot-previous)
imap <C-L><C-L> <Plug>(copilot-accept-line)

""" Text objects """
xnoremap <silent> il g_o^
onoremap <silent> il :normal vil<CR>
xnoremap <silent> al $o0
onoremap <silent> al :normal val<CR>
" Word including "."
onoremap <silent> iq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> iq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
onoremap <silent> aq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> aq :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
" Word including many other special chars except brackets and quotes
onoremap <silent> iQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
xnoremap <silent> iQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
onoremap <silent> aQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
	\setlocal iskeyword-=.,=,:<cr>
xnoremap <silent> aQ :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
	\setlocal iskeyword-=.,=,:<cr>

""" Colorschemes """
nnoremap <space>1 :<C-U>set background=dark\|colo soup-contrast<cr>
nnoremap <space>2 :<C-U>set background=dark\|colo allure<cr>
nnoremap <space>3 :<C-U>set background=dark\|colo lunaperche<cr>
nnoremap <space>4 :<C-U>set background=dark\|colo default<cr>
nnoremap <space>5 :<C-U>set background=light\|colo default<cr>
nnoremap <space>6 :<C-U>set background=light\|colo lunaperche<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>

""" Command mode """
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

""" Registers """
nnoremap yr% :let @+ = @%<cr>
nnoremap yr5 :let @+ = expand("%:h")<cr>
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

""" Which-key """
nnoremap <space>ww :<C-U>map<space>
nnoremap <space>wn :<C-U>nmap<space>
nnoremap <space>wi :<C-U>imap<space>
nnoremap <space>wc :<C-U>cmap<space>

""" Misc """
nnoremap yor <cmd>set rnu!<cr>
nnoremap <leader>u <cmd>undolist<cr>
" Expand default zM behaviour to allow specifying a foldlevel with [count]. Without a 
" [count], the behaviour is unchanged.
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
nnoremap <F5> :<C-U>Obsession<cr>
inoremap <C-Space> <C-X><C-O>
nnoremap <expr> <space>0 "<cmd>pedit +1 " .. getcwd(-1, -1) .. "/TODO.md<bar>wincmd p<cr>"

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
autocmd vimrc VimLeave * if !empty(v:this_session) | exe "CopilotChatSave " .. slice(substitute(getcwd(-1, -1), '/', '-', 'g'), 1) | endif
autocmd vimrc VimEnter * if !empty(v:this_session) | exe "CopilotChatLoad " .. slice(substitute(getcwd(-1, -1), '/', '-', 'g'), 1) | endif
autocmd vimrc ColorSchemePre * hi clear
autocmd vimrc BufWritePre * if g:format_on_save | call FormatBuf() | endif
autocmd vimrc OptionSet formatprg call s:SetFormatMaps()
autocmd vimrc OptionSet shiftwidth call s:SetSpaceIndentGuides(v:option_new)
autocmd vimrc BufWinEnter * call s:SetSpaceIndentGuides(&l:shiftwidth)
autocmd vimrc FileType * call s:SetFormatMaps()
autocmd vimrc FileType * set include=
autocmd vimrc BufRead * call s:SetJumpScopeMaps()
autocmd vimrc BufRead * set iskeyword+=-
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

"""""""""
" Final "
"""""""""

lua require('config')

colo allure

command! PackInstall call PackInit() | call minpac#update(keys(filter(copy(minpac#pluglist), 
	\{-> !isdirectory(v:val.dir . '/.git')})))
command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")
command! PackStatus packadd minpac | call minpac#status()
