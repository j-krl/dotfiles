nnoremap <buffer> % :<C-U>e <C-R>%
nnoremap <buffer> mk :<C-U>!mkdir -p <C-R>%
nnoremap <buffer> rm :<C-U>!rm <C-R>=isdirectory(getline(".")) ? "-r " : ""<cr><C-R>=getline(".")<cr>
nnoremap <buffer> cp :<C-U>!cp <C-R>=getline(".")<cr><space><C-R>=expand("%:p:h")<cr>/
nnoremap <buffer> CP :<C-U>!cp <C-R>=getline(".")<cr><space>
nnoremap <buffer> mv :<C-U>!mv <C-R>=getline(".")<cr><space><C-R>=expand("%:p:h")<cr>/
nnoremap <buffer> MV :<C-U>!mv <C-R>=getline(".")<cr><space>
nmap <buffer> - <Plug>(dirvish_up)
nnoremap <buffer> <C-L> <cmd>nohl\|Explore<cr>
