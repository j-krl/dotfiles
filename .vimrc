if !has('nvim')
    function! PackInit() abort
        "Make config semi-reusable between vim and neovim. Packages still need to be
        "defined in both places using a different plugin manager, but at least we are
        "generally using the same ones...
        packadd minpac
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        call minpac#add('mbbill/undotree')
        call minpac#add('christoomey/vim-tmux-navigator')
        call minpac#add('jeetsukumaran/vim-indentwise')
        call minpac#add('tpope/vim-surround')
        call minpac#add('tpope/vim-obsession')
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('tpope/vim-sleuth')
        call minpac#add('dense-analysis/ale')
    endfunction
endif

packadd cfilter

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
set wildignore=**/node_modules/**,**/venv/**,**/.venv/**,**/logs/**,**/.git/**,**/build/**
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git'
set statusline=%{ObsessionStatus()}\ %<%f\ %h%m%r%=%-13.(%l,%c%V%)\ %P
set fillchars=diff:\
set foldmethod=indent
set foldlevel=100
set foldlevelstart=100

let g:netrw_bufsettings = "noma nomod nu rnu ro nobl"
let g:tmux_navigator_no_mappings = 1
let g:surround_120 = "{/* \r */}" "JSX comments
let colodark = has('nvim') ? 'vim' : 'default'
let cololight = 'lunaperche'

noremap / ms/
noremap ? ms?
noremap * ms*
noremap # ms#
noremap +y "+y
noremap +p "+p
noremap +P "+P
noremap <leader>p "0p
noremap <leader>P "0P
nmap <expr> yccp "yy" .. v:count1 .. "gcc\']p"
nnoremap <leader>q <cmd>qa<cr>
nnoremap <leader>Q <cmd>qa!<cr>
nnoremap <leader>s a<cr><esc>k$
nnoremap <leader>S i<cr><esc>k$
nnoremap <silent> <expr> <C-J> 'ml:<C-U>keepp ,+' .. (v:count1 - 1) .. 's/\n\s*//g<cr>`l'
inoremap <C-S> <cr><esc>kA
nnoremap <Space> i_<esc>r
nnoremap <C-Space> a_<esc>r
inoremap <C-Space> <C-X><C-O>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
nnoremap yor <cmd>set rnu!<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
nnoremap <silent> <expr> yod ":colo " .. colodark .. "\|set background=dark<cr>"
nnoremap <silent> <expr> yol ":colo " .. cololight .. "\|set background=light<cr>"
nnoremap <leader>a <cmd>!git add %<cr>
nnoremap - <cmd>Explore<cr>

nnoremap <leader>u <cmd>UndotreeToggle<bar>UndotreeFocus<cr>
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>

"Diff the current buffer with its [count]th undo 
command! -count=1 DiffUndo :exe 'norm mu'|exe repeat('undo|', <count>)|%y|tab split|vnew|
    \setlocal bufhidden=delete|pu|wincmd l|exe repeat('redo|', <count>)|windo diffthis

augroup markgrep
    autocmd!
    autocmd QuickFixCmdPost l\=\(vim\)\=grep\(add\)\= norm mG
augroup END

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

augroup diffcolors
    autocmd!
    autocmd Colorscheme * call s:SetDiffHighlights()
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

if exists('&findfunc') && executable('fd')
    function! s:FdFindFunc(cmdarg, cmdcomplete)
        let cmd = "fd -p -H -L -E .git "
        if !a:cmdcomplete
            let cmd = cmd . "-t f "
        endif
        let result = systemlist(cmd . a:cmdarg) 
        if v:shell_error != 0
            echoerr result
            return []
        endif
        return result
    endfunction

    set findfunc=s:FdFindFunc
endif

if !has('nvim')
    let g:ale_linters = {'python': ['ruff']}

    command! PackUpdate call PackInit() | call minpac#update()
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus packadd minpac | call minpac#status()
endif

execute "silent! colorscheme " .. colodark
