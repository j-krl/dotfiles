if !has('nvim')
    function! PackInit() abort
        "Make config semi-reusable between vim and neovim. Packages still need to be
        "defined in both places using a different plugin manager, but at least we are
        "generally using the same ones...
        packadd minpac

        call minpac#init()
        call minpac#add('k-takata/minpac', {'type': 'opt'})

        call minpac#add('junegunn/fzf')
        call minpac#add('junegunn/fzf.vim')
        call minpac#add("mbbill/undotree")
        call minpac#add("christoomey/vim-tmux-navigator")
        call minpac#add('unblevable/quick-scope')
        call minpac#add('tpope/vim-surround')
        call minpac#add('tpope/vim-obsession')
        call minpac#add('tpope/vim-fugitive')
    endfunction
endif

packadd cfilter

syntax on
set relativenumber
set number
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80,88
set cursorline
set cursorlineopt=number
set signcolumn=yes
set autoread
set termguicolors
set undofile
set smartindent
set laststatus=2
set completeopt=menu,menuone
set wildmode=list:longest,full
set grepprg=rg\ --vimgrep\ --hidden\ -g\ '!.git'
set statusline=%{ObsessionStatus()}\ %<%f\ %h%m%r%=%-13.(%l,%c%V%)\ %P
set foldmethod=indent
set foldlevel=100
set foldlevelstart=100
set foldminlines=4
set background=dark
let $FZF_DEFAULT_OPTS = '--bind ctrl-d:half-page-down,ctrl-u:half-page-up,shift-down:preview-half-page-down,shift-up:preview-half-page-up'

:command BufOnly %bd|e#|bd#|norm `"

let mapleader = ' '
nnoremap - <cmd>Explore<cr>
nnoremap <C-W>N <cmd>tabnew<cr>
nnoremap <C-W>C <cmd>tabcl<cr>
nnoremap <C-W>Z <cmd>tab split<cr>
nnoremap yor <cmd>set rnu!<cr>
nnoremap <silent> yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
nnoremap <F5> <cmd>source Session.vim<cr>
nnoremap <leader>f <cmd>Files!<cr>
nnoremap <leader>g <cmd>RG!<cr>
nnoremap <leader>b <cmd>Buffers!<cr>
nnoremap <leader>u <cmd>UndotreeToggle<bar>UndotreeFocus<cr>
nnoremap <leader>q <cmd>qa<cr>
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-a>h <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-a>j <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-a>k <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-a>l <cmd>TmuxNavigateRight<cr>

augroup Gruvbox
    autocmd ColorScheme retrobox if &background == "dark" | highlight Normal guifg=#ebdbb2 guibg=#282828 | endif
    autocmd ColorScheme retrobox if &background == "dark" | highlight ColorColumn guibg=#3c3836 | endif
augroup END
colorscheme retrobox

if !has('nvim')
    command! PackUpdate call PackInit() | call minpac#update()
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus packadd minpac | call minpac#status()
endif
