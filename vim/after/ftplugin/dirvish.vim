nnoremap <buffer> % :<C-U>e <C-R>%
nnoremap <buffer> D :<C-U>!mkdir -p <C-R>%
nnoremap <buffer> dd :<C-U>!rm <C-R>=isdirectory(getline(".")) ? "-r " : ""<cr><C-R>=getline(".")<cr>
nmap <buffer> - <Plug>(dirvish_up)
nnoremap <silent> <buffer> a <cmd>call dirvish#open("rightbelow vsplit", 0)<cr>
nnoremap <silent> <buffer> o <cmd>call dirvish#open("rightbelow split", 0)<cr>
nnoremap <buffer> <C-L> <cmd>nohl\|Explore<cr>
