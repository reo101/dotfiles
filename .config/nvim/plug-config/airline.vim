let g:airline_powerline_fonts = 1
" let g:airline_theme = 'wal' " 'deus' "'bubblegum'
let g:airline_theme = 'monokai_tasty'
let g:airline#extensions#whitespace#enabled = 0

if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = '' " ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '' " '⭡'
    let g:airline_symbols.columnnr = 'C' " '\e0a3'
else
    let g:webdevicons_enable = 0
endif
