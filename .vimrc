if !has('nvim')
    "Make config semi-reusable between vim and neovim. Packages still need to be
    "defined in both places using a different plugin manager, but at least we are
    "generally using the same ones...
    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')
	call minpac#add("mbbill/undotree")
    call minpac#add('unblevable/quick-scope')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-fugitive')
endif

syntax on
set rnu
set number
set tabstop=4
set shiftwidth=4
set colorcolumn=80,88
set cursorline
set signcolumn=yes
set cursorlineopt=number
set autoread
set termguicolors
set expandtab
set undofile
set smartindent
set wildmode=list:longest,full
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99
set foldminlines=4
set laststatus=2
set completeopt=menu,menuone,preview
set grepprg=rg\ --vimgrep\ --hidden

let mapleader = ' '

nnoremap - :Explore<cr>
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]Q :cfirst<cr>
nnoremap [Q :clast<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
nnoremap ]L :lfirst<cr>
nnoremap [L :llast<cr>
nnoremap <C-W>O :tabnew<cr>
nnoremap <C-W>C :tabcl<cr>
nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<cr>

nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<cr>

let colodark = 'sorbet'
let cololight = 'lunaperche'
nnoremap yor :set rnu!<cr>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<cr><cr>
execute "nnoremap <silent> yod :colo " . colodark . "<cr>:set background=dark<cr>"
execute "nnoremap <silent> yol :colo " . cololight . "<cr>:set background=light<cr>"

let $FZF_DEFAULT_OPTS = '--bind "ctrl-d:half-page-down,ctrl-u:half-page-up,alt-d:preview-half-page-down,alt-u:preview-half-page-up"'
nnoremap <leader>f :Files!<cr>
nnoremap <leader>g :RG!<cr>
nnoremap <leader>h :History!<cr>
nnoremap <leader>c :Colors<cr>
nnoremap <leader>b :Buffers!<cr>
nnoremap <F5> :source Session.vim<cr>

execute "colorscheme " . colodark
