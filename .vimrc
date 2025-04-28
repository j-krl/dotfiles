if !has('nvim')
    function! PackInit() abort
        packadd minpac
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        call minpac#add('christoomey/vim-tmux-navigator')
        call minpac#add('tpope/vim-surround')
        call minpac#add('tpope/vim-obsession')
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('tpope/vim-sleuth')
        call minpac#add('tpope/vim-dotenv')
        call minpac#add('dense-analysis/ale')
    endfunction
endif

packadd cfilter

augroup vimrc
    autocmd!
augroup END

syntax on
set relativenumber
set number
set tabstop=4
set shiftwidth=4
set mouse=a
set expandtab
set re=0
set colorcolumn=80,88
set cursorline
set signcolumn=yes
set autoread
set termguicolors
set undofile
set smartindent
set laststatus=2
set completeopt=menuone,popup
set wildmode=list:longest,full
set wildignore=**/node_modules/*,**/venv/*,**/.venv/*,**/logs/*,\**/.git/*,\**/build/*,**/__pycache__/*
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git'
set statusline=%{ObsessionStatus()}\ %<%f\ %h%m%r\ %a%=%-13.(%l,%c%V%)\ %P
set fillchars=diff:\
set foldmethod=indent
set foldopen-=search
set foldlevel=100
set foldlevelstart=100

let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:tmux_navigator_no_mappings = 1
let g:surround_120 = "{/* \r */}" "JSX comments
let g:surround_100 = "\1dict: \1[\"\r\"]" "Python dict
let colodark = has('nvim') ? 'vim' : 'default'
let cololight = 'lunaperche'

noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
nmap <expr> ycc "yy" .. v:count1 .. "gcc\']p"
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. (v:count1 - 1) .. 's/\n\s*//g<cr>`l'
nnoremap <Space> i_<esc>r
nnoremap <C-S> a<cr><esc>k$
inoremap <C-S> <cr><esc>kA
inoremap <C-Space> <C-X><C-O>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
onoremap ik :<C-U>setlocal iskeyword+=.,-<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.,-<cr>
xnoremap ik :<C-U>setlocal iskeyword+=.,-<bar>exe 'norm! viw'<bar>setlocal iskeyword-=.,-<cr>
onoremap ak :<C-U>setlocal iskeyword+=.,-<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.,-<cr>
xnoremap ak :<C-U>setlocal iskeyword+=.,-<bar>exe 'norm! vaw'<bar>setlocal iskeyword-=.,-<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
nnoremap <silent> <expr> yod ":colo " .. colodark .. "\|set background=dark<cr>"
nnoremap <silent> <expr> yol ":colo " .. cololight .. "\|set background=light<cr>"
nnoremap <leader>g :grep <C-R><C-W><cr>
nnoremap <leader>a <cmd>!git add %<cr>
nnoremap - <cmd>Explore<cr>
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>

"Diff the current buffer with its [count]th undo 
command! -count=1 DiffUndo :exe 'norm mu' .. <count> .. 'u'|%y|tab split|vnew|
    \setlocal bufhidden=delete|pu|wincmd l|exe repeat('redo|', <count>)|windo diffthis

autocmd vimrc VimEnter * call s:SetProjectPath()
autocmd vimrc Colorscheme * call s:SetDiffHighlights()
autocmd vimrc QuickFixCmdPost l\=\(vim\)\=grep\(add\)\= norm mG

augroup gruvbox
    autocmd!
    autocmd ColorScheme retrobox if &background == "dark" | highlight Normal guifg=#ebdbb2 guibg=#282828 | endif
    autocmd ColorScheme retrobox if &background == "dark" | highlight ColorColumn guibg=#3c3836 | endif
augroup END

augroup monokai
    autocmd!
    autocmd ColorScheme unokai highlight Normal guifg=#f8f8f0 guibg=#26292c
    autocmd ColorScheme unokai highlight ColorColumn cterm=reverse guibg=#2e323c
    autocmd ColorScheme unokai highlight Identifier ctermfg=12 guifg=#f8f8f0
    autocmd ColorScheme unokai highlight PreProc guifg=#a6e22e
    autocmd ColorScheme unokai highlight Structure guifg=#66d9ef
    autocmd ColorScheme unokai highlight Comment gui=italic guifg=#9ca0a4
augroup END

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

function! s:SetProjectPath()
    if !filereadable(".vimenv")
        return
    endif
    Dotenv .vimenv
    if !empty($VIMPROJPATH)
        set path+=$VIMPROJPATH
    endif
endfunction

if !has('nvim')
    let g:ale_linters = {'python': ['ruff']}
    command! PackUpdate call PackInit() | call minpac#update()
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus packadd minpac | call minpac#status()
endif

execute "silent! colorscheme " .. colodark
