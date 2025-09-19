function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('unblevable/quick-scope')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('jeetsukumaran/vim-indentwise')
    call minpac#add('jpalardy/vim-slime')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('github/copilot.vim')
    call minpac#add('sheerun/vim-polyglot')
    if has("nvim")
        call minpac#add('neovim/nvim-lspconfig')
        call minpac#add('stevearc/conform.nvim')
        "call minpac#add('nvim-lua/plenary.nvim')
        "call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
    else
        call minpac#add('tpope/vim-commentary')
        call minpac#add('dense-analysis/ale')
        call minpac#add('ludovicchabant/vim-gutentags')
    endif
endfunction
packadd cfilter

augroup vimrc
    autocmd!
augroup END

if !has("nvim")
    " noselect not on stable vim yet
    set wildmode=full:longest:lastused,full
else
    set wildmode=noselect:longest:lastused,full
endif
set relativenumber
set number
set tabstop=4
set shiftwidth=4
set mouse=a
set expandtab
set re=0
set colorcolumn=80,88,120
set signcolumn=yes
set cursorline
set hidden
set autoread
set termguicolors
set undofile
set hlsearch
set smartindent
set laststatus=2
set completeopt=menuone,popup
set wildmenu
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,**/.git/*,**/build/*,**/__pycache__/*
set wildoptions=pum,tagfile
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git/*'
set guicursor=
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
set statusline=%{ObsessionStatus()}\ %<%f\ %h%m%r%=%-13a%-13.(%l,%c%V%)\ %P

if exists('&findfunc') && executable('fd') && executable('fzf')
    set findfunc=FuzzyFindFunc
endif

function! FuzzyFindFunc(cmdarg, cmdcomplete)
    return systemlist("fd --hidden -E '.git' . | fzf --filter='" .. a:cmdarg .. "'")
endfunction

""" Plugin options """
let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:python_indent = {
        \'open_paren': 'shiftwidth()',
        \'closed_paren_align_last_line': v:false
    \}
let g:vim_indent_cont = shiftwidth() * 2
let g:vim_markdown_new_list_item_indent = 0
let g:copilot_filetypes = {
        \'markdown': v:false
    \}
let g:tmux_navigator_no_mappings = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}
let g:slime_bracketed_paste = 1
let g:ale_linters = {
        \"python": ["ruff"],
        \"c": ["clangtidy"]
    \}
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_exclude = [ '*.git', '*.svg', '*.hg', 'build', 'dist', 'bin', 'node_modules', 'venv', '.venv', 'cache', 'docs', 'example', '*.md', '*.lock', '*bundle*.js', '*build*.js', '.*rc*', '*.json', '*.min.*', '*.bak', '*.zip', '*.pyc', '*.tmp', '*.cache', 'tags*', '*.css', '*.scss', '*.swp', ]
let g:ale_linters_explicit = 1
let g:ale_use_neovim_diagnostics_api = 0
let g:ale_virtualtext_cursor = 1
let g:ale_echo_cursor = 0
if has("nvim")
    let g:gutentags_enabled = 0
    let g:ale_enabled = 0
endif


""" Text manipulation """
nnoremap <leader>p <cmd>put "<cr>
nnoremap <leader>P <cmd>put! "<cr>
noremap <space>y "+y
noremap <space>p "+p
noremap <space>P "+P
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
nmap ]o ]<space>j
nmap [o [<space>k
inoremap <C-S> <cr><esc>kA
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
" Hungry delete
inoremap <silent> <expr> <bs> !search('\S','nbW',line('.')) ? 
        \(col('.') != 1 ? "\<C-U>" : "") .. "\<bs>" : "\<bs>"
inoremap <c-bs> <bs>
" Vim surround delete surrounding function. Uses text objects defined below
nmap dsf dib%hviel%p

""" File navigation """
noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <leader>x <cmd>xa<cr>
nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>W <cmd>wa<cr>
nnoremap <leader>b :<C-U>b<space>
nnoremap <leader>B :<C-U>Git blame<cr>
nnoremap <leader>f :<C-U>find<space>
nnoremap <leader>F :<C-U>vert sf<space>
nnoremap <leader>d :<C-U>Findqf<space>
nnoremap <leader>g :<C-U>grep ''<left>
nnoremap <leader>G :<C-U>grep <C-R><C-W><cr>
nnoremap <leader>z :<C-U>Zgrep<space>
nnoremap <leader>Z :<C-U>Fzfgrep<space>
nnoremap <leader>V ml:<C-U>lvim <C-R><C-W> %<cr>
nnoremap <leader>t :<C-U>tjump<space>
nnoremap <leader>T :<C-U>tjump <C-R><C-W><cr>
nnoremap <backspace> <C-^>
" go to definition (not in qflist)
nnoremap <expr> <cr> &buftype==# 'quickfix' ? "\<cr>" : "\<C-]>"
" go to definition of next function call
nnoremap gl t(<C-]>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
" close opposite horizontal split
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>v <C-W>v<C-W>w
nnoremap <C-W>s <C-W>s<C-W>w
" go to definition in vertical split
nmap <C-W>[ <C-W>v<C-]>
nmap <C-W>V <C-W>o<C-W>v
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>
nnoremap - <cmd>Explore<cr>
if !has("nvim")
    nnoremap ]q <cmd>cnext<cr>
    nnoremap [q <cmd>cprev<cr>
    nnoremap ]Q <cmd>clast<cr>
    nnoremap [Q <cmd>cfirst<cr>
    nnoremap ]l <cmd>lnext<cr>
    nnoremap [l <cmd>lprev<cr>
    nnoremap ]L <cmd>llast<cr>
    nnoremap [L <cmd>lfirst<cr>
    nnoremap ]<space> mmo<esc>`m<cmd>delm m<cr>
    nnoremap [<space> mmO<esc>`m<cmd>delm m<cr>
endif
" Annoying that there's no [count]th next tab command...
nnoremap <expr> ]w "<cmd>norm " .. repeat("gt", v:count1) .. "<cr>"
nnoremap [w gT
nnoremap [W <cmd>tabfirst<cr>
nnoremap ]W <cmd>tablast<cr>
nnoremap <space>w gt
nnoremap <leader>ll <cmd>lopen<cr>
nnoremap <leader>L <cmd>lclose<cr>
nnoremap <leader>cc <cmd>copen<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <leader>ch <cmd>chistory<cr>
nnoremap <expr> <leader>co ":<C-U>colder " .. v:count1 .. "<cr>"
nnoremap <expr> <leader>cn ":<C-U>cnewer " .. v:count1 .. "<cr>"
nnoremap <silent> <leader>cd :call RemoveQfEntry()<cr>
nnoremap <leader>cf :Cfilter<space>
nnoremap <leader>cz :Cfuzzy<space>
command! -nargs=+ Cfuzzy call FuzzyFilterQf(<f-args>)
command! -nargs=+ -complete=file_in_path Findqf call FdSetQuickfix(<f-args>)
command! -nargs=+ -complete=file_in_path Fzfgrep call FzfGrep(<f-args>)
command! -nargs=+ -complete=file_in_path Zgrep call FuzzyFilterGrep(<f-args>)

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

function! FuzzyFilterQf(...) abort
    call setqflist(matchfuzzy(getqflist(), join(a:000, " "), {'key': 'text'}))
endfunction

function! FdSetQuickfix(...) abort
    let fdresults = systemlist("fd -t f --hidden " .. join(a:000, " "))
    if v:shell_error
        echoerr "Fd error: " .. fdresults[0]
        return
    endif
    call setqflist(map(fdresults, {_, val -> {'filename': val, 'lnum': 1, 'text': val}}))
    copen
endfunction

function! RemoveQfEntry() abort
    let qfData = getqflist({'idx': 0, 'title': 0, 'items': 0})
    let qfIdx = get(qfData, 'idx', 0)
    let qfTitle = get(qfData, 'title', 0)
    let qfItems = get(qfData, 'items', 0)
    if qfIdx == 0
        return
    endif
    let filteredItems = filter(qfItems, {idx -> idx != qfIdx - 1})
    call setqflist([], 'r', {'items': filteredItems, 'title': qfTitle})
    if len(filteredItems) > 0
        exe qfIdx .. 'cc'
    endif
endfunction

""" Arglist """
nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr><esc>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
nnoremap <F2> <C-L><cmd>args<cr>
nnoremap <leader>aa <cmd>$arge %<bar>argded<bar>args<cr>
nnoremap <leader>ap <cmd>0arge %<bar>argded<bar>args<cr>
nnoremap <leader>ad <cmd>argd %<bar>args<cr>
nnoremap <leader>ac <cmd>%argd<cr><C-L>
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

""" ALE """
nnoremap <C-K> <cmd>ALEDetail<cr>

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
" Word including many other chars except brackets and quotes
onoremap <silent> iE :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! viw'<bar>
        \setlocal iskeyword-=.,-,=,:<cr>
xnoremap <silent> iE :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! viw'<bar>
        \setlocal iskeyword-=.,-,=,:<cr>
onoremap <silent> aE :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! vaw'<bar>
        \setlocal iskeyword-=.,-,=,:<cr>
xnoremap <silent> aE :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! vaw'<bar>
        \setlocal iskeyword-=.,-,=,:<cr>

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
nnoremap <space>8 :<C-U>set background=light\|colo peachpuff<cr>

""" Regex """
cnoremap <C-space> .*
cnoremap <A-9> \(
cnoremap <A-0> \)
cnoremap <A-space> \<space>
cnoremap <A-.> \.

""" Buffers """
command! BOnly %bd|e#|bd#|norm `"
command! BDelete e#|bd#
command! BActive call s:CloseHiddenBuffers()

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

""" Misc """
nnoremap yor <cmd>set rnu!<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
nnoremap <leader>u <cmd>undolist<cr>
" Expand default zM behaviour to allow specifying a foldlevel with [count]. Without a 
" [count], the behaviour is unchanged.
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
nnoremap <F5> :Obsession<cr>
" Omni completion
inoremap <C-Space> <C-X><C-O>
nnoremap <leader>A <cmd>!git add %<cr>
" Copy name of current file to system register
nnoremap yrc :let @+ = @%<cr>
" Copy last yank to system register
nnoremap yrs :let @+ = @0<cr>
if !has("nvim")
    nnoremap <silent> <C-L> <cmd>nohl<cr>
endif

""""""""""""""""
" Autocommands "
""""""""""""""""

autocmd vimrc QuickFixCmdPost * norm mG
autocmd vimrc BufEnter * let b:workspace_folder = getcwd() "Copilot
if has("nvim")
    autocmd vimrc TabNewEntered * argl|%argd
endif

"""""""""""""""""""""""""
" Colorscheme overrides "
"""""""""""""""""""""""""

augroup colors
    autocmd!
augroup END

autocmd colors ColorSchemePre * hi clear
autocmd colors ColorScheme * call s:ColorschemeOverrides()

function! s:ColorschemeOverrides()
    hi clear PreProc
    hi clear Type
    hi clear Constant
    hi Constant gui=BOLD
    hi! link Boolean Constant
    hi! link Float Constant
    hi! link Number Constant
    hi! link Include Statement
    hi! link Operator Statement
    hi! link Special Statement
    hi! link Structure Function
    hi! link Function Identifier
    hi Comment guifg=grey50
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
    endif
    " colorscheme specific
    if g:colors_name == "retrobox"
        if &background == "dark"
            hi Normal guifg=#ebdbb2 guibg=#282828
            hi String ctermfg=214 guifg=#fabd2f
            hi Identifier cterm=bold ctermfg=142 gui=bold guifg=#b8bb26
        else
            hi String ctermfg=172 guifg=#b57614
            hi Identifier cterm=bold ctermfg=64 gui=bold guifg=#79740e
        endif
    elseif g:colors_name == "lunaperche"
        if &background == "dark"
            hi Identifier ctermfg=116 guifg=#5fd7d7
        else
            hi Identifier ctermfg=23 guifg=#005f5f
        endif
    elseif g:colors_name == "unokai"
        hi Normal guifg=#f8f8f0 guibg=#26292c
        hi Identifier ctermfg=112 guifg=#a6e22e
        hi Statement guifg=#ff6188 
    elseif g:colors_name == "slate"
        hi Identifier ctermfg=223 guifg=#ffd7af
    elseif g:colors_name == "default" && has("nvim")
        hi TabLineSel gui=reverse
        if &background == "dark"
            hi Statement ctermfg=14 guifg=NvimLightCyan
        else
            hi Statement ctermfg=6 guifg=NvimDarkCyan
        endif
    endif
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
    " python
    hi! link pythonFunctionCall Normal
    hi! link pythonClassVar Function
    hi! link pythonBuiltinType Normal
    hi! link pythonBuiltinFunc Normal
    " vim
    hi! link vimBracket Identifier
    hi! link vimCommentString Comment
endfunction

"""""""""""""
" Filetypes "
"""""""""""""

augroup ftpython
    autocmd!
    autocmd FileType python call s:SetupPython()
augroup END
function! s:SetupPython()
    let b:surround_{char2nr("d")} = "\1dict: \1[\"\r\"]"
    let b:surround_{char2nr("m")} = "\"\"\"\r\"\"\""
    let b:surround_{char2nr("p")} = "f\"\r\""
    let b:surround_{char2nr("P")} = "f\'\r\'"
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
endfunction

augroup fttypescript
    autocmd!
    autocmd FileType javascriptreact,typescriptreact,javascript,typescript call s:SetupReact()
augroup END
function s:SetupReact()
    " JSX comment
    let b:surround_{char2nr("x")} = "{/* \r */}"
    " Template string
    let b:surround_{char2nr("p")} = "${`\r`}"
    nmap <silent> <buffer> dsx ds/dsB
    " jump to next const on line with no starting white space
    noremap <silent> <buffer> ]1 <cmd>for i in range(v:count1)\|
            \call search('^\(export \)\=const', 'W')\|endfor<cr>
    noremap <silent> <buffer> [1 <cmd>for i in range(v:count1)\|
            \call search('^\(export \)\=const', 'bW')\|endfor<cr>
    iab co const 
endfunction

if has("nvim")
    autocmd vimrc FileType lua,help,query lua vim.treesitter.stop()
endif

augroup ftmarkdown
    autocmd!
    autocmd FileType markdown iab -] - [ ] 
augroup END

"""""""""
" Final "
"""""""""

if has("nvim")
    lua require('config')
endif

if strftime("%H") >= 22 || strftime("%H") < 7
    colo habamax
else
    colo slate
endif

command! PackInstall call PackInit() | call minpac#update(keys(filter(copy(minpac#pluglist), 
        \{-> !isdirectory(v:val.dir . '/.git')})))
command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")
command! PackStatus packadd minpac | call minpac#status()
