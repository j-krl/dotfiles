set number
set rnu
set tabstop=4
set shiftwidth=2
set colorcolumn=80,88
set cursorline
set culopt=number
set autoread
set termguicolors
set expandtab
set undofile
set smartindent
set wildmode=list:longest,full
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()
set foldminlines=4
set foldlevelstart=99

let mapleader = ' '

nnoremap - :Explore<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :cfirst<CR>
nnoremap [Q :clast<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>
nnoremap ]L :lfirst<CR>
nnoremap [L :llast<CR>
nnoremap <C-W>O :tabnew<CR>
nnoremap <C-W>C :tabcl<CR>
nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10)v:count)<Bar>execute "\'[-1<CR>
nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>

let colodark = 'sorbet'
let cololight = 'lunaperche'
nnoremap yor :set rnu!<CR>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
execute "nnoremap <silent> yod :colo " . colodark . "<CR>:set background=dark<CR>"
execute "nnoremap <silent> yol :colo " . cololight . "<CR>:set background=light<CR>"

if !has('nvim')
  "Make config semi-reusable between vim and neovim. Packages still need to be
  "defined in both places using different plugin manager, but at least we are
  "generally using the same ones...
  call plug#begin()
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'unblevable/quick-scope'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-obsession'
  call plug#end()
endif

nnoremap <leader>f :Files<CR>
nnoremap <leader>g :RG<CR>

execute "colorscheme " . colodark
