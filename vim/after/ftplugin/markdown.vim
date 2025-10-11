setlocal spell
set iskeyword-=-
" md sources the html which sets this, so unset
setlocal formatprg=
inoremap <expr> <tab> getline(".") =~# "^[ \t]*[\-\*]" ? "<C-T>" : "<tab>"
