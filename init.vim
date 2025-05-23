function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('jeetsukumaran/vim-indentwise')
    call minpac#add('justinmk/vim-sneak')
    call minpac#add('unblevable/quick-scope')
    call minpac#add('jpalardy/vim-slime')
    call minpac#add('luochen1990/rainbow')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('tpope/vim-dotenv')
    call minpac#add('tpope/vim-dadbod')
    call minpac#add('github/copilot.vim')
    if has('nvim')
        call minpac#add('neovim/nvim-lspconfig')
        call minpac#add('stevearc/conform.nvim')
        call minpac#add('nvim-lua/plenary.nvim')
        call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
    else
        call minpac#add('dense-analysis/ale')
        call minpac#add('tpope/vim-commentary')
        call minpac#add('DanBradbury/copilot-chat.vim')
    endif
endfunction
packadd cfilter

augroup vimrc
    autocmd!
augroup END

"""""""""""
" Options "
"""""""""""

if !has('nvim')
    " Setting syntax on in nvim clashes with vim-slime
    syntax on
endif

set relativenumber
set number
set tabstop=4
set shiftwidth=4
set mouse=a
set expandtab
" Typescript syntax highlighting is very slow in vim if `re` isn't explicitly set
set re=0
set colorcolumn=80,88,120
set cursorline
set signcolumn=yes
set autoread
set termguicolors
set undofile
set hlsearch
set smartindent
set laststatus=2
set completeopt=menuone,popup
set wildmode=list:longest,full
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,**/.git/*,**/build/*,**/__pycache__/*
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git'
" Add session status and arglist position to statusline
set statusline=%{ObsessionStatus()}\ %<%f\ %h%m%r%=%-13a%-13.(%l,%c%V%)\ %P
set guicursor=
set fillchars=diff:\
set foldmethod=indent
set foldopen-=search
set foldlevel=100
set foldlevelstart=100
set background=dark
let g:maplocalleader = "_"
let g:markdown_fenced_languages = ["python", "javascript", "typescript", "html", "css", "json", "vim", "lua"]

" Plugin options
let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:python_indent = {
        \'open_paren': 'shiftwidth()',
        \'closed_paren_align_last_line': v:false
    \}
let g:vim_indent_cont = shiftwidth() * 2
let g:tmux_navigator_no_mappings = 1
let g:rainbow_ts_after = 'syn clear typescriptBlock @typescriptDestructures @typescriptCallSignature typescriptFuncCallArg typescriptConditionalParen typescriptTemplateSubstitution typescriptTernary typescriptObjectLiteral typescriptArray typescriptTypeBracket typescriptTypeBlock @typescriptFunctionType typescriptParenthesizedType typescriptParenExp typescriptExceptions'
let g:rainbow_conf = {
        \'separately': {
            \'typescriptreact': {
                \'parentheses_options': 'containedin=ALL contains=typescriptIdentifierName',
                \'after': [g:rainbow_ts_after]
            \},
            \'typescript': {
                \'parentheses_options': 'containedin=ALL contains=typescriptIdentifierName',
                \'after': [g:rainbow_ts_after]
            \},
            \'vim': {
                \'parentheses_options': 'containedin=vimFuncBody',
                \'after': ['syn clear vimOperParen vimFunction']
            \},
            \'help': 0
        \}
    \}
let g:rainbow_active = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}
let g:slime_bracketed_paste = 1
if !has('nvim')
    let g:ale_linters = {'python': ['ruff']}
endif

""""""""""""
" Mappings "
""""""""""""

" Text manipulation
noremap +y "+y
noremap +Y "+Y
noremap +p "+p
noremap +P "+P
nnoremap <leader>p <cmd>put "<cr>
nnoremap <leader>P <cmd>put! "<cr>
nnoremap <leader>0p <cmd>put 0<cr>
nnoremap <leader>0P <cmd>put! 0<cr>
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap <expr> <leader>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <leader>S v:count >= 1 ? ":s/<C-R><C-W>/" : ":%s/<C-R><C-W>/"
nnoremap <space>s a<cr><esc>k$
nnoremap <space>S i<cr><esc>k$
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. (v:count < 2 ? v:count - 1: v:count - 2)
            \ .. 's/\n\s*//g<cr>`l'
nnoremap go o<esc>
nnoremap gO O<esc>
inoremap <C-S> <cr><esc>kA
inoremap <C-H> <C-U><backspace>
inoremap `<tab> ``<Left>
inoremap "<tab> ""<Left>
inoremap '<tab> ''<Left>
inoremap <<tab> <><Left>
inoremap (<tab> ()<Left>
inoremap [<tab> []<Left>
inoremap {<tab> {}<Left>
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
" Requires vim-surround and `e` text object to be set below. Only works for a
" single line
nmap dsf %<left>diedsb

" File & pane navigation
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <leader>x <cmd>xa<cr>
nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>W <cmd>wa<cr>
nnoremap <backspace> <C-^>
nnoremap <leader>b :call feedkeys(":b <tab>", "tn")<cr>
nnoremap <leader>f :find 
nnoremap <leader>F :vert sf 
nnoremap <leader>g :grep ''<left>
nnoremap <leader>G :grep '<C-R><C-W>'<cr>
nnoremap <leader>o :browse filter  o<left><left>
nnoremap <leader>mm <cmd>marks HJKLMN<cr>
nnoremap <leader>ml <cmd>marks hjklmn<cr>
nnoremap <leader>M <cmd>delm HJKLMN<cr>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>v <C-W>v<C-W>w
nnoremap <C-W>s <C-W>s<C-W>w
nmap <C-W>[ <C-W>v<C-]>
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>
nnoremap - <cmd>Explore<cr>
nnoremap <leader>cc <cmd>copen<cr>
nnoremap <leader>C <cmd>cclose<cr>
nnoremap <silent> <expr> <leader>co ":colder " .. v:count1 .. "<cr>"
nnoremap <silent> <expr> <leader>cn ":cnewer " .. v:count1 .. "<cr>"
nnoremap <silent> <leader>cd :call RemoveQfEntry()<cr>

function! RemoveQfEntry()
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

" Arglist
nnoremap [a <cmd>exe v:count1 .. 'N'<bar>args<cr><esc>
nnoremap ]a <cmd>exe v:count1 .. 'n'<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
nnoremap <F2> <cmd>args<cr>
nnoremap <leader>aa <cmd>$arge %<bar>argded<bar>args<cr>
nnoremap <leader>ap <cmd>0arge %<bar>argded<bar>args<cr>
nnoremap <leader>ad <cmd>argd %<bar>args<cr>
nnoremap <leader>ac <cmd>%argd<cr><C-L>
nnoremap <silent> <expr> ga ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"

" Searching
noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap gl t(<C-]>
nnoremap <expr> <cr> &buftype==# 'quickfix' ? "\<cr>" : "\<C-]>"

" Copilot
imap <C-J> <Plug>(copilot-accept-word)
imap <C-L><C-L> <Plug>(copilot-next)
imap <C-L><C-K> <Plug>(copilot-previous)
imap <C-L><space> <Plug>(copilot-accept-line)

" Text objects
xnoremap <silent> il g_o^
onoremap <silent> il :normal vil<CR>
xnoremap <silent> al $o0
onoremap <silent> al :normal val<CR>
onoremap <silent> ie :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.,-,=,:<cr>
xnoremap <silent> ie :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.,-,=,:<cr>
onoremap <silent> ae :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.,-,=,:<cr>
xnoremap <silent> ae :<C-U>setlocal iskeyword+=.,-,=,:<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.,-,=,:<cr>

" Colorschemes
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
nnoremap <expr> <space>1 ":colo " .. (has('nvim') ? 'vim' : 'default') .. "<cr>"
nnoremap <space>2 :colo retrobox<cr>
nnoremap <space>3 :colo sorbet<cr>
nnoremap <space>4 :colo habamax<cr>
nnoremap <space>5 :colo slate<cr>
nnoremap <space>6 :colo desert<cr>
nnoremap <space>7 :colo zaibatsu<cr>
nnoremap <space>8 :colo peachpuff<cr>
nnoremap <space>9 :colo shine<cr>
nnoremap <space>0 :colo default<cr>

" Misc
cnoremap <C-\><C-W> .*?
nnoremap yor <cmd>set rnu!<cr>
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
inoremap <C-Space> <C-X><C-O>
nnoremap <leader>A <cmd>!git add %<cr>
nnoremap <leader>D mvvip:DB<cr>`v
if !has('nvim')
    nnoremap <C-L> <cmd>noh<cr>
endif

""""""""""""
" Commands "
""""""""""""

command! BOnly %bd|e#|bd#|norm `"
command! BDelete e#|bd#
command! BActive call s:CloseHiddenBuffers()
command! -count=1 DiffUndo :exe 'norm mu' .. <count> .. 'u'|%y|tab split|vnew|
    \setlocal bufhidden=delete|pu|wincmd l|exe repeat('redo|', <count>)|windo diffthis

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

autocmd vimrc QuickFixCmdPost * norm mG
autocmd vimrc TabClosed * tabprevious
autocmd vimrc BufEnter * let b:workspace_folder = getcwd()
autocmd vimrc BufEnter * call s:SetWorkspaceEnv()
autocmd vimrc DirChanged * call s:SetWorkspaceEnv()
autocmd vimrc BufEnter .vimrc,~/.config/nvim/** call s:CheckConfigSchedule() 
autocmd vimrc BufEnter * RainbowToggleOn
autocmd vimrc ColorScheme * call s:SetHighlights()
autocmd vimrc ColorScheme * highlight link CopilotSuggestion MoreMsg
autocmd vimrc ColorScheme retrobox if &background == "dark" | highlight Normal guifg=#ebdbb2 guibg=#282828 | endif
autocmd vimrc ColorScheme \(desert\)\|\(evening\)\|\(vim\) highlight CursorLine guibg=gray28

augroup cursorline
    autocmd!
    autocmd VimEnter * setlocal cursorline
    autocmd WinEnter * setlocal cursorline
    autocmd BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
if has('nvim')
    " `TabNewEntered` does not exist in vim
    autocmd vimrc TabNewEntered * argl|%argd
endif

function! s:SetWorkspaceEnv()
    set path&
    if !filereadable(".vimenv")
        return
    endif
    Dotenv .vimenv
    if !empty($VIMPROJPATH)
        set path+=$VIMPROJPATH
    endif
endfunction

function! s:CheckConfigSchedule()
    let hour = strftime("%H")
    let weekday = strftime("%w")
    let is_work_hour = hour >= 9 && hour <= 14
    let is_night = hour >= 22 || hour <= 5
    if is_work_hour || is_night
        bd
    endif
endfunction

function! s:SetHighlights()
    if &background == "dark"
        highlight DiffAdd gui=BOLD guifg=NONE guibg=#2e4b2e
        highlight DiffDelete gui=BOLD guifg=NONE guibg=#4c1e15
        highlight DiffChange gui=BOLD guifg=NONE guibg=#3e4d53
        highlight DiffText gui=BOLD guifg=NONE guibg=#5c4306
        highlight ColorColumn guibg=#3c3836
    else
        highlight DiffAdd gui=BOLD guifg=NONE guibg=palegreen
        highlight DiffDelete gui=BOLD guifg=NONE guibg=lightred
        highlight DiffChange gui=BOLD guifg=NONE guibg=lightblue
        highlight DiffText gui=BOLD guifg=NONE guibg=palegoldenrod
        highlight ColorColumn ctermbg=255 guibg=#eeeeee
    endif
endfunction

" Filetype specific configs
augroup ftpython
    autocmd!
    autocmd FileType python call s:SetupPython()
augroup END
function! s:SetupPython()
    let b:surround_{char2nr("d")} = "\1dict: \1[\"\r\"]"
    let b:surround_{char2nr("m")} = "\"\"\"\r\"\"\""
    let b:surround_{char2nr("t")} = "f\"\r\""
    let b:surround_{char2nr("T")} = "f\'\r\'"
    nmap dsd %<left>dieds]ds"
    nmap dsm ds"ds"ds"
    nnoremap <buffer> <localleader>d ciw"<C-R>""<right><backspace>:<space><esc>
    nnoremap <buffer> <localleader>D di"a<backspace><backspace><C-R>"<right><right><backspace><backspace>=<esc>
    nnoremap <buffer> <localleader>b obreakpoint()<esc>
    nnoremap <buffer> <localleader>B Obreakpoint()<esc>
    nnoremap <buffer> <localleader>F mfF"if<esc>`fl
    nnoremap <buffer> <localleader>gc :grep 'class \('<left><left><left>
    nnoremap <buffer> <localleader>gd :grep 'def \('<left><left><left>
endfunction

augroup ftreact
    autocmd!
    autocmd FileType javascriptreact,typescriptreact call s:SetupReact()
augroup END
function s:SetupReact()
    let b:surround_{char2nr("x")} = "{/* \r */}"
    nmap <silent> <buffer> dsx ds/dsB
    nnoremap <silent> <buffer> ]1 :exe "sil keepp norm! /^const\<lt>cr>"\|noh<cr>
    nnoremap <silent> <buffer> [1 :exe "sil keepp norm! ?^const\<lt>cr>"\|noh<cr>
    nnoremap <buffer> <localleader>gd :grep "^const  =>"<left><left><left><left>
endfunction

augroup ftlua
    autocmd!
    if has('nvim')
        " This is the only way to disable lua treesitter highlighting...
        autocmd FileType lua lua vim.treesitter.stop()
    endif
augroup END

if has('nvim')
    lua require('config')
endif

colo slate

command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")

