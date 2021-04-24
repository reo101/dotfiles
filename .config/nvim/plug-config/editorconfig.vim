" Dont screw with vim-fugitive and dont try to read ssh-ed files .editorconfigs
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Disable EditorConfig for Java
" au FileType java let b:EditorConfig_disable = 1

" Disable rule
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
