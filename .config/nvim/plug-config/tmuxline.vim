let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

" Stock presets
"let g:tmuxline_preset = 'nightly_fox'
" or
"let g:tmuxline_preset = 'full'
" or
"let g:tmuxline_preset = 'tmux'
" other presets available in autoload/tmuxline/presets/*

" Custom presets
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '',
      \'y'    : '%H:%M',
      \'z'    : '#H'}

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'c'    : '#H',
"       \'win'  : '#I #W',
"       \'cwin' : '#I #W',
"       \'x'    : '%a',
"       \'y'    : '#W %R',
"       \'z'    : '#H'}

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'win'  : ['#I', '#W'],
"       \'cwin' : ['#I', '#W', '#F'],
"       \'y'    : ['%R', '%a', '%Y'],
"       \'z'    : '#H'}

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'c'    : ['#(whoami)', '#(uptime | cut -d " " -f 1,2,3)'],
"       \'win'  : ['#I', '#W'],
"       \'cwin' : ['#I', '#W', '#F'],
"       \'x'    : '#(date)',
"       \'y'    : ['%R', '%a', '%Y'],
"       \'z'    : '#H'}

" #H    Hostname of local host
" #h    Hostname of local host without the domain name
" #F    Current window flag
" #I    Current window index
" #S    Session name
" #W    Current window name
" #(shell-command)  First line of the command's output

" Uncomment to accept apply themes
"let g:airline#extensions#tmuxline#enabled = 0

"let g:tmuxline_theme = 'iceberg'
" or
"let g:tmuxline_theme = 'zenburn'
" or
"let g:tmuxline_theme = 'jellybeans'
" other themes available in autoload/tmuxline/themes/*

" let g:tmuxline_theme = {
"     \   'a'    : [ 236, 103 ],
"     \   'b'    : [ 253, 239 ],
"     \   'c'    : [ 244, 236 ],
"     \   'x'    : [ 244, 236 ],
"     \   'y'    : [ 253, 239 ],
"     \   'z'    : [ 236, 103 ],
"     \   'win'  : [ 103, 236 ],
"     \   'cwin' : [ 236, 103 ],
"     \   'bg'   : [ 244, 236 ],
"     \ }
" values represent: [ FG, BG, ATTR ]
"   FG ang BG are color codes
"   ATTR (optional) is a comma-delimited string of one or more of bold, dim, underscore, etc. For details refer to the STYLE section in the tmux man page

