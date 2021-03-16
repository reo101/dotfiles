" file finder mapping
nmap ,e :Files<CR>

" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>

" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>

" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>

" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>

" general code finder in current file mapping
nmap ,f :BLines<CR>

" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>

" general code finder in all files mapping
nmap ,F :Lines<CR>

" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>j
" commands finder mapping
nmap ,c :Commands<CR>
