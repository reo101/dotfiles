lua <<EOF
vim.cmd('packadd nvim-lspconfig')
require'nvim_lsp'.clangd.setup(name="clangd", settings = {},)
EOF

let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'cpp': ['clangd', '-background-index',],
    \ }
