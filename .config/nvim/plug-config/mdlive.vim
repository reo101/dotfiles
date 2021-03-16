let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0 " 1 is for reloading on BufWrite
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0 " 1 is for preview over network
let g:mkdp_open_ip = '' " Check Pull RQ 9 for more info
let g:mkdp_browser = 'vimb'
let g:mkdp_browserfunc = '' " Open previe funciton name
" let g:mkdp_preview_options = '' " Check github page
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = 'MD preview' " '『${name}』'
let g:mkdp_filetypes = ['markdown']

nmap <C-m> <Plug>MarkdownPreviewToggle
