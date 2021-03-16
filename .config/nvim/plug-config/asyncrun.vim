" Open quickfix window automatically when AsyncRun is executed
" set the quickfix window 6 lines in height
"let g:asyncrun_open = 6

" Ring the bell to notify for finished job
"let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6) <CR>
