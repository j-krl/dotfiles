function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('jeetsukumaran/vim-indentwise')
    call minpac#add('unblevable/quick-scope')
    call minpac#add('jpalardy/vim-slime')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-sleuth')
    call minpac#add('tpope/vim-dotenv')
    call minpac#add('tpope/vim-dadbod')
    call minpac#add('github/copilot.vim')
    call minpac#add('kadekillary/skull-vim')
    call minpac#add('axvr/photon.vim')
    call minpac#add('karoliskoncevicius/sacredforest-vim')
    if has("nvim")
        call minpac#add('neovim/nvim-lspconfig')
        call minpac#add('stevearc/conform.nvim')
        call minpac#add('nvim-lua/plenary.nvim')
        call minpac#add('CopilotC-Nvim/CopilotChat.nvim')
        call minpac#add('olivercederborg/poimandres.nvim')
    endif
endfunction
packadd cfilter

augroup vimrc
    autocmd!
augroup END

"""""""""""
" Options "
"""""""""""

set relativenumber
set number
set tabstop=4
set shiftwidth=4
set mouse=a
set expandtab
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
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git/*'\ -g\ '!**/migrations/*'
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
let g:markdown_fenced_languages = ["python", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "json", "vim", "lua"]

" Plugin options
let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:python_indent = {
        \'open_paren': 'shiftwidth()',
        \'closed_paren_align_last_line': v:false
    \}
let g:vim_indent_cont = shiftwidth() * 2
let g:tmux_navigator_no_mappings = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}
let g:slime_bracketed_paste = 1

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
nnoremap <space><space> i_<esc>r
inoremap <C-S> <cr><esc>kA
inoremap <C-H> <C-U><backspace>
inoremap {<cr> {<cr>}<C-O>O
inoremap [<cr> [<cr>]<C-O>O
inoremap (<cr> (<cr>)<C-O>O
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
nnoremap <leader>mm <cmd>marks<cr>
nnoremap <leader>mc <cmd>delm a-z<cr>
nnoremap <leader>mC <cmd>delm A-Z<cr>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
nnoremap <C-W>X <C-W>x<C-W>c
nnoremap <C-W>v <C-W>v<C-W>w
nnoremap <C-W>s <C-W>s<C-W>w
nmap <C-W>[ <C-W>v<C-]>
nmap <C-W>r <C-W>o<C-W>v
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
nnoremap [a <cmd>call NavArglist(v:count1 * -1)<bar>args<cr><esc>
nnoremap ]a <cmd>call NavArglist(v:count1)<bar>args<cr><esc>
nnoremap [A <cmd>first<bar>args<cr><esc>
nnoremap ]A <cmd>last<bar>args<cr><esc>
nnoremap <F2> <C-L><cmd>args<cr>
nnoremap <leader>aa <cmd>$arge %<bar>argded<bar>args<cr>
nnoremap <leader>ap <cmd>0arge %<bar>argded<bar>args<cr>
nnoremap <leader>ad <cmd>argd %<bar>exe 'norm <C-L>'<bar>args<cr>
nnoremap <leader>ac <cmd>%argd<cr><C-L>
nnoremap <expr> ga ":<C-U>" .. (v:count > 0 ? v:count : "") .. "argu\|args<cr><esc>"

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


" Searching
noremap / ms/
noremap ? ms?
nnoremap gl t(<C-]>
nnoremap <expr> <cr> &buftype==# 'quickfix' ? "\<cr>" : "\<C-]>"

" Copilot
imap <C-J> <Plug>(copilot-accept-word)
imap <C-L><C-]> <Plug>(copilot-dismiss)
imap <C-L><C-K> <Plug>(copilot-next)
imap <C-L><C-J> <Plug>(copilot-previous)
imap <C-L><C-L> <Plug>(copilot-accept-line)

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
nnoremap <space>1 :set background=dark\|colo default<cr>
nnoremap <space>2 :colo poimandres<cr>
nnoremap <space>3 :colo skull<cr>
nnoremap <space>4 :colo photon<cr>
nnoremap <space>5 :colo sacredforest<cr>
nnoremap <space>6 :set background=light\|colo default<cr>
nnoremap <space>7 :colo antiphoton<cr>

" Misc
nnoremap yfc :let @+ = @%<cr>
cnoremap <C-\><C-W> .*?
nnoremap yor <cmd>set rnu!<cr>
nnoremap <leader>u <cmd>undolist<cr>
nnoremap <silent> <expr> zM ':<C-U>set foldlevel=' .. v:count .. '<cr>'
inoremap <C-Space> <C-X><C-O>
nnoremap <leader>A <cmd>!git add %<cr>
nnoremap <leader>D mvvip:DB<cr>`v

""""""""""""
" Commands "
""""""""""""

command! BOnly %bd|e#|bd#|norm `"
command! BDelete e#|bd#
command! BActive call s:CloseHiddenBuffers()
command! -nargs=1 FixArglist call FixArglistHack(<args>)

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

" Terrible hack for weird local arglist issues when used with sessions where
" working directory was changed
function! FixArglistHack(prefix)
    let broken_arglist = argv()
    %argd
    for entry in broken_arglist
        let newpath = substitute(entry, '\(' .. a:prefix .. '\)*', '', '')
        exe 'arga ' .. newpath
    endfor
endfunction

""""""""""""""""
" Autocommands "
""""""""""""""""

autocmd vimrc QuickFixCmdPost * norm mG
autocmd vimrc BufEnter * let b:workspace_folder = getcwd()
autocmd vimrc BufEnter * call s:SetWorkspaceEnv()
autocmd vimrc DirChanged * call s:SetWorkspaceEnv()
autocmd vimrc ColorScheme sacredforest call s:ModifySacredForestColorScheme()
autocmd vimrc Colorscheme skull call s:ModifySkullColorScheme()
autocmd vimrc Colorscheme poimandres call s:ModifyPoimandresColorScheme()
autocmd vimrc Colorscheme photon call s:ModifyPhotonColorScheme()
autocmd vimrc ColorScheme * call s:SetDiffHighlights()
if has("nvim")
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

function! s:ModifyPhotonColorScheme()
    hi PreProc guifg=#a0a0a0
    hi Statement guifg=#a0a0a0
    hi Special guifg=#a0a0a0
    hi! link Identifier Statement
    hi! link typescriptDestructureVariable Normal
endfunction

function! s:ModifySacredForestColorScheme()
     hi LineNr gui=BOLD cterm=BOLD
     hi Conditional guifg=#b2a488
     hi Include guifg=#b2a488
     hi Comment guifg=grey58
     hi! link Operator Keyword
     hi! link Type Normal
     hi! link Statement Normal
     hi! link PreProc Normal
     hi! link DiagnosticUnnecessary Conceal
     hi! link typescriptDestructureVariable Normal
     hi! link typescriptConditional Conditional
     hi! link pythonStatement pythonBuiltin
     hi! link pythonInclude Include
     hi! link pythonException Conditional
endfunction

function! s:ModifyPoimandresColorScheme()
    hi ColorColumn guibg=#506477
    hi Visual guifg=NONE
    hi! link Type Normal
    hi! link Conditional Function
    hi! link Special Function
    hi! link Keyword Normal
    hi! link Identifier Normal
    hi! link typescriptParenExp Normal
endfunction

function! s:ModifySkullColorScheme()
     hi TabLineSel gui=underline cterm=underline
     hi ColorColumn guifg=NONE ctermfg=NONE
     hi PmenuSel gui=UNDERLINE
     hi! link LineNr Conceal
     hi! link DiagnosticUnnecessary Conceal
     hi! link StatusLineNC VisualNOS
     hi! link Visual StatusLine
     hi! link Special Statement
endfunction

function! s:SetDiffHighlights()
    if &background == "dark"
        hi DiffAdd gui=BOLD guifg=NONE guibg=#2e4b2e
        hi DiffDelete gui=BOLD guifg=NONE guibg=#4c1e15
        hi DiffChange gui=BOLD guifg=NONE guibg=#3e4d53
        hi DiffText gui=BOLD guifg=NONE guibg=#5c4306
    else
        hi DiffAdd gui=BOLD guifg=NONE guibg=palegreen
        hi DiffDelete gui=BOLD guifg=NONE guibg=lightred
        hi DiffChange gui=BOLD guifg=NONE guibg=lightblue
        hi DiffText gui=BOLD guifg=NONE guibg=palegoldenrod
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
    let b:surround_{char2nr("p")} = "f\"\r\""
    let b:surround_{char2nr("P")} = "f\'\r\'"
    nmap <buffer> dsd %<left>dieds]ds"
    nmap <buffer> dsm ds"ds"ds"
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
    autocmd FileType javascriptreact,typescriptreact,javascript,typescript call s:SetupReact()
augroup END
function s:SetupReact()
    let b:surround_{char2nr("x")} = "{/* \r */}"
    let b:surround_{char2nr("p")} = "${`\r`}"
    nmap <silent> <buffer> dsx ds/dsB
    noremap <silent> <buffer> ]1 :<C-U>exe "sil keepp norm! /^\\(export \\)\\=const\<lt>cr>"\|noh<cr>
    noremap <silent> <buffer> [1 :<C-U>exe "sil keepp norm! ?^\\(export \\)\\=const\<lt>cr>"\|noh<cr>
    nnoremap <buffer> <localleader>gd :grep "^\(export \)?const  = \("<left><left><left><left><left><left>
    iab co const
endfunction

augroup ftlua
    autocmd!
    autocmd FileType lua lua vim.treesitter.stop()
augroup END

if has("nvim")
    lua require('config')
endif

command! -nargs=? PackUpdate call PackInit() | call minpac#update(<args>)
command! PackClean call PackInit() | call minpac#clean()
command! PackList call PackInit() | echo join(sort(keys(minpac#getpluglist())), "\n")

