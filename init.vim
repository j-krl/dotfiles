function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('jeetsukumaran/vim-indentwise')
    call minpac#add('jpalardy/vim-slime')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('tpope/vim-dotenv')
    call minpac#add('tpope/vim-dadbod')
    if has('nvim')
        " Neovim only packages
        call minpac#add("neovim/nvim-lspconfig")
        call minpac#add("jinh0/eyeliner.nvim")
        call minpac#add("stevearc/conform.nvim")
        call minpac#add("supermaven-inc/supermaven-nvim")
    else
        " Vim only packages
        call minpac#add('unblevable/quick-scope')
        call minpac#add('dense-analysis/ale')
        call minpac#add('tpope/vim-commentary')
    endif
endfunction

" Global augroup to use with ungrouped autocmds
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
set colorcolumn=80,88
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

" Plugin options
let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:python_indent = {
        \'open_paren': 'shiftwidth()',
        \'closed_paren_align_last_line': v:false
    \}
let g:tmux_navigator_no_mappings = 1
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
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap <expr> <leader>s v:count >= 1 ? ":s/" : ":%s/"
nnoremap <expr> <leader>S v:count >= 1 ? ":s/<C-R><C-W>/" : \":%s/<C-R><C-W>/"
nnoremap s a<cr><esc>k$
nnoremap S i<cr><esc>k$
inoremap <C-S> <cr><esc>kA
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. (v:count < 2 ? v:count - 1: v:count - 2)
            \ .. 's/\n\s*//g<cr>`l'
inoremap <A-backspace> <C-W><backspace>
inoremap "<tab> ""<Left>
inoremap '<tab> ''<Left>
inoremap (<tab> ()<Left>
inoremap [<tab> []<Left>
inoremap {<tab> {}<Left>
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
" Requires vim-surround and `e` text object to be set below
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
nnoremap <leader>g :grep ""<left>
nnoremap <leader>G :grep <C-R><C-W><cr>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>v <C-W>v<C-W>w
nnoremap <C-W>s <C-W>s<C-W>w
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>
nnoremap - <cmd>Explore<cr>
nnoremap <leader>cc <cmd>copen<cr>
nnoremap <leader>C <cmd>cclose<cr>
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
nnoremap [a <cmd>exe 'sil ' ..  v:count1 .. 'wN'<bar>args<cr><esc>
nnoremap ]a <cmd>exe 'sil ' ..  v:count1 .. 'wn'<bar>args<cr><esc>
nnoremap [A <cmd>w<bar>first<bar>args<cr><esc>
nnoremap ]A <cmd>w<bar>last<bar>args<cr><esc>
nnoremap <A-s> <cmd>args<cr>
nnoremap <A-a> <cmd>sil w<bar>$arge %<bar>argded<bar>redrawstatus<bar>args<cr>
nnoremap <A-A> <cmd>sil w<bar>0arge %<bar>argded<bar>redrawstatus<bar>args<cr>
nnoremap <A-d> <cmd>argd %<bar>redrawstatus<bar>args<cr>
nnoremap <A-D> <cmd>%argd<bar>redrawstatus<cr>
nnoremap <silent> <expr> <leader>a ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"

" Searching
noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
nnoremap gl t(<C-]>
nnoremap <expr> <cr> &buftype==# 'quickfix' ? "\<cr>" : "\<C-]>"

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
nnoremap <A-c>r :colo retrobox<cr>
nnoremap <A-c>u :colo unokai<cr>
nnoremap <A-c>h :colo habamax<cr>
nnoremap <A-c>s :colo sorbet<cr>
nnoremap <A-c>l :colo lunaperche<cr>
nnoremap <A-c>t :colo slate<cr>
nnoremap <expr> <A-c>v ":colo " .. (has('nvim') ? 'vim' : 'default') .. "<cr>"

" Misc
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

autocmd vimrc QuickFixCmdPost l\=\(vim\)\=grep\(add\)\= norm mG
autocmd vimrc BufEnter * call s:SetWorkspaceEnv()
autocmd vimrc DirChanged * call s:SetWorkspaceEnv()
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

autocmd vimrc Colorscheme * call s:SetDiffHighlights()
function! s:SetDiffHighlights()
    if &background == "dark"
        highlight DiffAdd gui=BOLD guifg=NONE guibg=#2e4b2e
        highlight DiffDelete gui=BOLD guifg=NONE guibg=#4c1e15
        highlight DiffChange gui=BOLD guifg=NONE guibg=#3e4d53
        highlight DiffText gui=BOLD guifg=NONE guibg=#5c4306
    else
        highlight DiffAdd gui=BOLD guifg=NONE guibg=palegreen
        highlight DiffDelete gui=BOLD guifg=NONE guibg=lightred
        highlight DiffChange gui=BOLD guifg=NONE guibg=lightblue
        highlight DiffText gui=BOLD guifg=NONE guibg=palegoldenrod
    endif
endfunction

autocmd vimrc Colorscheme retrobox call s:SetGruvboxHighlights()
function! s:SetGruvboxHighlights()
    if &background == "dark"
        highlight ColorColumn guibg=#3c3836
        highlight Normal guifg=#ebdbb2 guibg=#282828
    endif
endfunction

autocmd vimrc Colorscheme unokai call s:SetMonokaiHighlights()
function! s:SetMonokaiHighlights()
    highlight Normal guifg=#f8f8f0 guibg=#26292c
    highlight ColorColumn cterm=reverse guibg=#2e323c
    highlight Identifier ctermfg=12 guifg=#f8f8f0
    highlight PreProc guifg=#a6e22e
    highlight Structure guifg=#66d9ef
    highlight Comment gui=italic guifg=#9ca0a4
endfunction

" Filetype specific configs
augroup ftpython
    autocmd!
    autocmd FileType python let b:surround_{char2nr("d")} = "\1dict: \1[\"\r\"]"
    autocmd FileType python nnoremap <buffer> <localleader>d ciw"<C-R>""<right><backspace>:<space><esc>
    autocmd FileType python nnoremap <buffer> <localleader>D di"a<backspace><backspace><C-R>"
                \<right><right><backspace><backspace>=<esc>
    autocmd FileType python nnoremap <buffer> <localleader>b obreakpoint()<esc>
    autocmd FileType python nnoremap <buffer> <localleader>B Obreakpoint()<esc>
augroup END

augroup ftreact
    autocmd FileType javascriptreact,typescriptreact 
                \let b:surround_{char2nr("x")} = "{/* \r */}"
    autocmd FileType javascriptreact,typescriptreact 
                \nnoremap <silent> <buffer> <localleader>] 
                \:exe "sil keepp norm! /^const\<lt>cr>"\|noh<cr>
    autocmd FileType javascriptreact,typescriptreact 
                \nnoremap <silent> <buffer> <localleader>[ 
                \:exe "sil keepp norm! ?^const\<lt>cr>"\|noh<cr>
augroup END

if has('nvim')
    lua require('config')
    colo vim
endif

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")

