setlocal formatprg=prettier\ %
" Template string
let b:surround_{char2nr("p")} = "${`\r`}"
" jump to next const on line with no starting white space
noremap <silent> <buffer> ]1 <cmd>for i in range(v:count1)\|
        \call search('^\(export \)\=const', 'W')\|endfor<cr>
noremap <silent> <buffer> [1 <cmd>for i in range(v:count1)\|
        \call search('^\(export \)\=const', 'bW')\|endfor<cr>
