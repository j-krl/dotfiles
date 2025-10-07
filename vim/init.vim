function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('unblevable/quick-scope')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('jeetsukumaran/vim-indentwise')
    call minpac#add('jpalardy/vim-slime')
    call minpac#add('gcmt/taboo.vim')
    call minpac#add('justinmk/vim-dirvish')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-rhubarb')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('github/copilot.vim')
    call minpac#add('sheerun/vim-polyglot')
    if has("nvim")
        call minpac#add('neovim/nvim-lspconfig')
        call minpac#add('stevearc/conform.nvim')
        call minpac#add('nvim-lua/plenary.nvim')
        call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
    else
        call minpac#add('tpope/vim-commentary')
    endif
endfunction
packadd cfilter

"""""""""""
" Options "
"""""""""""

""" Vim options """
if !has("nvim")
    " noselect not on stable vim yet
    set wildmode=full:longest:lastused,full
else
    set wildmode=noselect:longest:lastused,full
    set undofile
endif
set relativenumber
set number
set tabstop=4
set shiftwidth=4
set mouse=a
set expandtab
set nofixeol
set re=0
set colorcolumn=80,88,120
set signcolumn=yes
set cursorline
" Required for taboo to persist names in sessions
set sessionoptions+=globals
set hidden
set autoread
set termguicolors
set hlsearch
set smartindent
set laststatus=2
set completeopt=menuone,popup
set wildmenu
set list
set listchars=tab:\|\ 
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,**/.git/*,**/build/*,**/__pycache__/*
set wildoptions=pum,tagfile
set wildcharm=<tab>
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git/*'
set tabclose=left
set guicursor=
set iskeyword+=-
set fillchars=diff:\
set foldmethod=indent
set foldopen-=search
set foldlevel=100
set foldlevelstart=100
set background=dark
let g:maplocalleader = "_"
let g:markdown_fenced_languages = ["python", "javascript", "javascriptreact", "typescript",
    \"typescriptreact", "html", "css", "json", "vim", "lua"]
" Add session status and arglist position to statusline
set statusline=%{ObsessionStatus()}\ %<%f\ \ %{FugitiveStatusline()}%h%m%r%=%-13a%-13.(%l,%c%V%)\ %P
if has("nvim")
    let &packpath = stdpath("data") .. "/site," .. substitute(&packpath, stdpath("data") .. "/site,", "", "g")
else
    set packpath^=~/.local/share/vim/site
endif
if exists('&findfunc') && executable('fd') && executable('fzf')
    set findfunc=FuzzyFindFunc
endif

function! FuzzyFindFunc(cmdarg, cmdcomplete)
    return systemlist("fd --hidden -E '.git' . | fzf --filter='" .. a:cmdarg .. "'")
endfunction

""" Plugin options """
" Sort directories above
let g:dirvish_mode = ':sort ,^.*[\/],'
" Disable netrw
let g:loaded_netrwPlugin = 1
let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_banner = 0
let g:netrw_keepj = ""
let g:python_indent = {
        \'open_paren': 'shiftwidth()',
        \'closed_paren_align_last_line': v:false
    \}
let g:polyglot_disabled = ["autoindent"] "Sleuth is making me do this?
let g:vim_indent_cont = shiftwidth()
let g:vim_markdown_new_list_item_indent = 0
let g:copilot_filetypes = {
        \'markdown': v:false,
        \'copilot-chat': v:false
    \}
let g:tmux_navigator_no_mappings = 1
let g:taboo_tab_format = " %N %P "
let g:taboo_renamed_tab_format = " %N %l "
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}
let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:qf_session_auto_cache = 2
let g:qf_session_auto_load = 1
let g:qf_cache_dir = expand("~") .. "/.cache/vim/"

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
if !has("nvim")
    nnoremap ]<space> mmo<esc>`m<cmd>delm m<cr>
    nnoremap [<space> mmO<esc>`m<cmd>delm m<cr>
endif
nmap ]o ]<space>j
nmap [o [<space>k
" Hungry delete
inoremap <silent> <expr> <bs> !search('\S','nbW',line('.')) ? 
    \(col('.') != 1 ? "\<C-U>" : "") .. "\<bs>" : "\<bs>"
inoremap <c-bs> <bs>
" Vim surround delete surrounding function. Uses text objects defined below
nmap dsf dib%hviel%p

""" System register """
noremap <space>y "+y
noremap <space>p "+p
noremap <space>P "+P
nnoremap <A-p> <cmd>put +<cr>
nnoremap <A-P> <cmd>put! +<cr>

""" Save & Quit """
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <leader>x <cmd>xa<cr>
nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>W <cmd>wa<cr>

""" File navigation """
noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap <backspace> <C-^>
" go to definition (not in qflist)
nnoremap <expr> <cr> &buftype==# 'quickfix' ? "\<cr>" : "\<C-]>"
" close opposite split
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>v <C-W>v<C-W>w
nnoremap <C-W>s <C-W>s<C-W>w
" go to definition in vertical split
nmap <C-W>[ <C-W>v<C-]>
nmap <C-W>] <C-W>]<C-W>r
nmap <C-W>V <C-W>o<C-W>v
nnoremap <leader>b :<C-U>b<space><tab>
nnoremap <leader>f :<C-U>find<space>
nmap <leader>F :<C-U>find <C-H><tab>
nnoremap <leader>g :<C-U>grep ''<left>
nnoremap <leader>G :<C-U>grep <C-R><C-W><cr>
nnoremap <leader>z :<C-U>Zgrep<space>
nnoremap <leader>Z :<C-U>Fzfgrep<space>
nnoremap <leader>V ml:<C-U>lvim <C-R><C-W> %\|lwindow<cr><cr>
nnoremap ]f <cmd>call NavDirFiles(v:count1)<cr>
nnoremap [f <cmd>call NavDirFiles(v:count1 * -1)<cr>
cnoremap <C-H> <C-R>=expand("%:.:h")<cr>/
command! Bonly %bd|e#|bd#|norm `"
command! Bdelete e#|bd#
command! Bactive call s:CloseHiddenBuffers()
command! -nargs=+ -complete=file_in_path Fzfgrep call FzfGrep(<f-args>)
command! -nargs=+ -complete=file_in_path Zgrep call FuzzyFilterGrep(<f-args>)

""" Slime """
nnoremap <expr> <leader>tc '<cmd>SlimeSend1 cd ' .. getcwd() .. '<cr><cmd>TmuxNavigateDown<cr>'

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
nnoremap <space>- :<C-U><c-r>=bufname() == "" ? "set bufhidden=\|" : ""<cr>
    \exe "Explore " .. getcwd()<cr>

""" Tmux """
noremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
noremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
noremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
noremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>

""" Quickfix/Location list """
if !has("nvim")
    nnoremap ]q <cmd>exe v:count1 .. "cnext"<cr>
    nnoremap [q <cmd>exe v:count1 .. "cprev"<cr>
    nnoremap ]Q <cmd>exe v:count1 .. "clast"<cr>
    nnoremap [Q <cmd>exe v:count1 .. "cfirst"<cr>
    nnoremap ]l <cmd>exe v:count1 .. "lnext"<cr>
    nnoremap [l <cmd>exe v:count1 .. "lprev"<cr>
    nnoremap ]L <cmd>exe v:count1 .. "llast"<cr>
    nnoremap [L <cmd>exe v:count1 .. "lfirst"<cr>
endif
nnoremap <leader>ll <cmd>lwindow<cr>
nnoremap <leader>L <cmd>lclose<cr>
nnoremap <leader>cc <cmd>cwindow<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <expr> <leader>ch "<cmd>" .. (v:count > 0 ? v:count : "")
        \.. "chistory" .. (v:count > 0 ? "\|cw" : "") .. "<cr>"
nnoremap <leader>cL <cmd>clist<cr>
nnoremap <leader>lL <cmd>llist<cr>
nnoremap <leader>c<leader> <cmd>exe (v:count > 0 ? v:count : ".") .. "cc"<cr>
nnoremap <leader>l<leader> <cmd>exe (v:count > 0 ? v:count : ".") .. "ll"<cr>
nnoremap <leader>cl <cmd>echo len(getqflist())<cr>
nnoremap <leader>lc <cmd>echo len(getloclist(winnr()))<cr>
nnoremap <expr> <silent> <leader>cd "<cmd>" .. v:count1 .. "Cditem<cr>"
nnoremap <leader>cf :<C-U>Cfilter<space>
nnoremap <leader>cF :<C-U>Cfilter!<space>
nnoremap <leader>cz :<C-U>Cfuzzy<space>
nnoremap <expr> <leader>cD "<cmd>Chdelete " .. v:count .. "<cr>"
nnoremap <leader>cn <cmd>Clist<cr>
nnoremap <leader>cr :<C-U>Cdelete<space><tab>
nnoremap <leader>cs :<C-U>Csave<space>
nnoremap <leader>co :<C-U>Cload<space><tab>

""" Tabs """
nnoremap <leader><leader> gt
nnoremap <expr> ]w "<cmd>norm " .. repeat("gt", v:count1) .. "<cr>"
nnoremap [w gT
nnoremap [W <cmd>tabfirst<cr>
nnoremap ]W <cmd>tablast<cr>
nnoremap <C-W>N <cmd>tabnew\|Explore<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W><tab> g<tab>
" Split to next tab with no [count], otherwise split to [count]th index. Like
" `<C-W>T`, but don't close the original window
nnoremap <C-W>S :<C-U>exe (v:count > 0 ? v:count - 1 : "") .. "tab split"<cr>
" Move tab to the end without a [count] otherwise move to [count]th index
nnoremap <C-W>M :<C-U>exe (v:count > 0 ? 
    \(tabpagenr() < v:count ? v:count : (v:count - 1)) : "$") .. "tabmove"<cr>
" Change tab's working directory to the current file
nnoremap <C-W>D :<C-U>exe "tcd " .. (&ft == "netrw" \|\| &ft == "dirvish" ? "%" : "%:h")<cr>

""" Fugitive/Git """
" Git status summary
nnoremap <space>gg :<C-U>G<cr>
nnoremap <space>gb :<C-U>Git blame<cr>
nnoremap <space>go :<C-U>GBrowse<cr>
" Switch to the working directory version of the current file
nnoremap <space>ge :<C-U>Gedit<cr>
nnoremap <space>gE :<C-U>Gedit :%<left><left>
nnoremap <space>gB :<C-U>!git branch --show-current<cr>
nnoremap <space>gv :<C-U>Gvdiffsplit<space>
" Load all past revisions of the current file into the qflist
nnoremap <space>g0 :<C-U>0Gclog<cr>
nnoremap <space>gt :<C-U>Git difftool<space>
nnoremap <space>gA <cmd>!git add %<cr>

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
" Go to arglist file at index [count]
nnoremap <expr> <space><space> ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"

""" Copilot """
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
onoremap <silent> ie :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> ie :<C-U>setlocal iskeyword+=.<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.<cr>
onoremap <silent> ae :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
xnoremap <silent> ae :<C-U>setlocal iskeyword+=.<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.<cr>
" Word including many other special chars except brackets and quotes
onoremap <silent> iE :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
    \setlocal iskeyword-=.,=,:<cr>
xnoremap <silent> iE :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! viw'<bar>
    \setlocal iskeyword-=.,=,:<cr>
onoremap <silent> aE :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
    \setlocal iskeyword-=.,=,:<cr>
xnoremap <silent> aE :<C-U>setlocal iskeyword+=.,=,:<bar>exe 'norm! vaw'<bar>
    \setlocal iskeyword-=.,=,:<cr>

""" Colorschemes """
nnoremap <space>1 :<C-U>set background=dark\|colo default<cr>
nnoremap <space>! :<C-U>set background=light\|colo default<cr>
nnoremap <space>2 :<C-U>set background=dark\|colo lunaperche<cr>
nnoremap <space>@ :<C-U>set background=light\|colo lunaperche<cr>
nnoremap <space>3 :<C-U>set background=dark\|colo slate<cr>
nnoremap <space>4 :<C-U>set background=dark\|colo unokai<cr>
nnoremap <space>5 :<C-U>set background=dark\|colo sorbet<cr>
nnoremap <space>6 :<C-U>set background=dark\|colo retrobox<cr>
nnoremap <space>^ :<C-U>set background=light\|colo retrobox<cr>
nnoremap <space>7 :<C-U>set background=dark\|colo habamax<cr>
nnoremap <space>8 :<C-U>set background=dark\|colo zaibatsu<cr>
nnoremap <space>9 :<C-U>set background=light\|colo peachpuff<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>

""" Regex """
cnoremap <C-space> .*
cnoremap <A-9> \(
cnoremap <A-0> \)
cnoremap <A-space> \<space>
cnoremap <A-.> \.

""" Registers """
nnoremap yr% :let @+ = @%<cr>
nnoremap yr~ :let @+ = expand("%:~")<cr>
nnoremap yr` :let @+ = expand("%:~:h")<cr>
nnoremap yr. :let @+ = expand("%:.")<cr>
nnoremap yr> :let @+ = expand("%:.:h")<cr>
nnoremap yrp :let @+ = expand("%:p")<cr>
nnoremap yrP :let @+ = expand("%:p:h")<cr>
nnoremap yr+ :let @+ = @0<cr>
nmap yr0 yr+
nnoremap yrb :let @+ = system("git branch --show-current")<cr>

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
nnoremap <F5> :Obsession<cr>
" Omni completion
inoremap <C-Space> <C-X><C-O>
if !has("nvim")
    nnoremap <silent> <C-L> <cmd>nohl<cr>
endif

""" Functions """
" WARNING: slow!
function! FzfGrep(query, path=".")
    let oldgrepprg = &grepprg
    let &grepprg = "rg --column --hidden -g '!.git/*' . " .. a:path .. 
            \" \\| fzf --filter='$*' --delimiter : --nth 4.."
    exe "grep " .. a:query
    let &grepprg = oldgrepprg
endfunction

function! FuzzyFilterGrep(query, path=".") abort
    exe "grep! '" .. a:query .. "' " .. a:path
    let sort_query = substitute(a:query, '\.\*', '', 'g')
    let sort_query = substitute(sort_query, '\\\(.\)', '\1', 'g')
    call FuzzyFilterQf(sort_query)
    cfirst
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

""""""""""""""""
" Autocommands "
""""""""""""""""

augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufEnter * let b:workspace_folder = getcwd() "Copilot
autocmd vimrc VimEnter * if argc() == 0 && empty(v:this_session) | Dirvish | endif
autocmd vimrc VimLeave * if !empty(v:this_session) | exe 
    \'call writefile(["colorscheme " .. g:colors_name], v:this_session, "a")' | endif
if has("nvim")
    autocmd vimrc TabNewEntered * argl|%argd
endif
autocmd vimrc BufRead,BufNewFile *.jinja2 set filetype=jinja2
autocmd vimrc ColorSchemePre * hi clear

"""""""""
" Final "
"""""""""

if has("nvim")
    lua require('config')
endif

if strftime("%H") >= 22 || strftime("%H") < 7
    colo habamax
else
    sil! colo unokai
    if !exists("g:colors_name")
        colo slate
    endif
endif

command! PackInstall call PackInit() | call minpac#update(keys(filter(copy(minpac#pluglist), 
        \{-> !isdirectory(v:val.dir . '/.git')})))
command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")
command! PackStatus packadd minpac | call minpac#status()
