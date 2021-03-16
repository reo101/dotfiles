" FIXME problem with swallow dwm V
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'xelatex'
let g:livepreview_cursorhold_recompile = 0

" autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
"autocmd BufWritePost *.tex silent exec '!compiler '.shellescape('%')
autocmd BufWritePost *.tex AsyncRun compiler "%"
