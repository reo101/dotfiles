"                                 ___     
"        ___        ___          /__/\    
"       /__/\      /  /\        |  |::\   
"       \  \:\    /  /:/        |  |:|:\  
"        \  \:\  /__/::\      __|__|:|\:\ 
"    ___  \__\:\ \__\/\:\__  /__/::::| \:\
"   /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
"   \  \:\|  |:|     \__\::/  \  \:\      
"    \  \:\__|:|     /__/:/    \  \:\     
"     \__\::::/      \__\/      \  \:\    
"         ~~~~                   \__\/    

" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.0.1

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal
" (if you aren't using one of those fonts, you will see funny characters here.
" Turst me, they look nice when using one of those fonts).
let fancy_symbols_enabled = 1

set runtimepath+=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after

set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Override configs by directory
" with a `.vim.custom` rc file
Plug 'arielrossanigo/dir-configs-override.vim'

" Code commenter
"Plug 'scrooloose/nerdcommenter' " TODO learn hotkeys
Plug 'tpope/vim-commentary'

" Better targets
" ci( from beggining of line
Plug 'wellle/targets.vim'

" Better file browser
Plug 'vifm/vifm.vim' " TODO learn hotkeys
" Plug 'scrooloose/nerdtree'

" Class/module browser
" Uses `tags` but not required
Plug 'majutsushi/tagbar'

" Search results counter
" "At match #N out of   "atches"
Plug 'vim-scripts/IndexedSearch'

" Colorschemes
Plug 'fisadev/fisa-vim-colorscheme'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'Reewr/vim-monokai-phoenix'
Plug 'tomasr/molokai'


" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " TODO learn hotkeys

" Pending tasks list
" TODO and FIXME lookup
Plug 'fisadev/FixedTaskList.vim'

" Async autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}

" Completion from other opened files
Plug 'Shougo/context_filetype.vim'

" Automatically close parenthesis, etc
" Now managed by CoC
" Plug 'Townk/vim-autoclose'

" Autoclose
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround' " TODO learn hotkeys

" Indent text object
" Defines text objects for identetions (Python)
Plug 'michaeljsmith/vim-indent-object' " TODO learn hotkeys

" Indentation based movements
" Keymaps to jump between indents
Plug 'jeetsukumaran/vim-indentwise' " TODO learn hotkeys

" Vast language syntax highlighting and indentation
Plug 'sheerun/vim-polyglot'

" Ack code search (requires ack installed in the system)
" Replaces grep
Plug 'mileszs/ack.vim' " TODO see `:help Ack`

" Paint css colors with the real color "
"Plug 'lilydjwg/colorizer'
Plug 'RRethy/vim-hexokinase' " TODO make settings

" Window chooser
" Press `-`* to select vim window to focus
Plug 't9md/vim-choosewin' " TODO learn hotkeys

" Highlight matching html tags
Plug 'valloric/MatchTagAlways'

" Generate html in a simple way
Plug 'mattn/emmet-vim' " TODO learn syntax

" Git integration
Plug 'tpope/vim-fugitive'
" :GBrowse for GitHub
Plug 'tpope/vim-rhubarb'
" :GBrowse ofr GitLab
Plug 'shumphrey/fugitive-gitlab.vim'

" Git/mercurial/others diff icons on the side of the file lines
if using_neovim || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Yank history navigation
" ^P and ^N for prev/next yanks
" Replaced by coc-yank
" Plug 'vim-scripts/YankRing.vim'

" Automated and better `:make`
Plug 'neomake/neomake' " TODO see `:help neomake.txt`

" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

" ultisnips
" Plug 'SirVer/ultisnips'
" vim-snippets
" Plug 'honza/vim-snippets'

" CPP syntax
" Managed by polyglot
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'jackguo380/vim-lsp-cxx-highlight'
"Plug 'bfrg/vim-cpp-modern'

" wal
Plug 'dylanaraps/wal.vim'

" Rainbow brackets
" Replaced by coc-omnisharp " FIXME
" Plug 'frazrepo/vim-rainbow'

" vim-dispatch
" replaced by neomake
"Plug 'tpope/vim-dispatch'


" asyncrun
Plug 'skywind3000/asyncrun.vim' " TODO learn commands

" CMake
" Plug 'vhdirk/vim-cmake'

" fakeclip
" Clipboard registers (with xclip)
" Plug 'kana/vim-fakeclip'

" vim-repeat
" used by surround
" Repeat more complex actions with `.`
Plug 'tpope/vim-repeat'

" goyo
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Rich graphical debugger
Plug 'puremourning/vimspector'

" Windows maximizer
" Basically Ctrl+w o
Plug 'szw/vim-maximizer'

" Wakatime
" Time counter per project
Plug 'wakatime/vim-wakatime'

" Code formatting
" codefmt uses maktaba and Glaive is used for configuring it
"Plug 'google/vim-maktaba'
"Plug 'google/vim-glaive', { 'do': 'call glaive#Install()' }
" `:NoAutoFormatBuffer` to temporaly stop the formatting
"Plug 'google/vim-codefmt'

" Treesitter for syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" LaTeX
" vimtex
Plug 'lervag/vimtex'
"Plug 'lervag/vimtex' " TODO learn how to use this instead of vim-latex-live-preview
" Plug 'ying17zi/vim-live-latex-preview'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Json with comments
Plug 'kevinoid/vim-jsonc'

if using_neovim
    " Markdown Live Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
endif

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    " vim 8.0 also has its own now
    " Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" VimWiki
Plug 'vimwiki/vimwiki'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    " no vi-compatible
    set nocompatible

    " *try* remove 1s delay when entering NORMAL mode
    set timeoutlen=1000 ttimeoutlen=0

    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
else
    set hidden
    set ignorecase
    set smartcase
    set inccommand=split
    set lazyredraw
    set relativenumber number
    set splitbelow splitright
    set undofile
    set omnifunc=syntaxcomplete#Complete
    set suffixesadd=.java
endif

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars-=vert:\| | set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|xterm-256color\|screen-256\|st\|st-256\|st-256color')
    if !has('gui_running')
        set termguicolors
        " colorscheme wal "vim-monokai-tasty
        colorscheme vim-monokai-tasty
        let &t_Co = 256
    endif
    "if (&term =~? 'xterm\|xterm-256\|xterm-256color')
    if (&term =~? 'st\|st-256\|st-256color') && using_vim
        set term=xterm-256color
        set notermguicolors
        " set term=st-256color
        autocmd VimEnter * set term=st-256color
        set termguicolors
    endif
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " colorscheme monokai-phoenix "vim-monokai-tasty
else
    colorscheme delek
endif

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=longest:full,full

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" recompile dwmblocks after editing the config file
" autocmd BufWritePost $HOME/suckless/dwmblocks/config.h silent exec '!cd $HOME/suckless/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }' | redraw!
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/zsh


" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
" map <F3> :NERDTreeToggle<CR>
map <F3> :Vifm<CR>

" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>

" don't show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.out$']

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Tasklist ------------------------------

" show pending tasks list
map <S-F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0

" Fzf ------------------------------

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

" Conquerer of Completion --------------

source $HOME/.config/nvim/plug-config/coc.vim

let g:coc_global_extensions = [
    \ 'coc-yank',
    \ 'coc-vimlsp',
    \ 'coc-tasks',
    \ 'coc-snippets',
    \ 'coc-prettier',
    \ 'coc-lists',
    \ 'coc-lbdbq',
    \ 'coc-json',
    \ 'coc-highlight',
    \ 'coc-github-users',
    \ 'coc-emmet',
    \ 'coc-discord',
    \ 'coc-db',
    \ 'coc-calc',
    \ 'coc-browser',
    \ 'coc-actions',
    \ 'coc-tsserver',
    \ 'coc-texlab',
    \ 'coc-styled-components',
    \ 'coc-sh',
    \ 'coc-python',
    \ 'coc-java',
    \ 'coc-java-debug',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-cmake'
    \ ]

    " \ 'coc-java-vimspector',

" CoC Snippets -------------------------

"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? coc#_select_confirm() :
      "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" VimWiki ------------------------------

source $HOME/.config/nvim/plug-config/vimwiki.vim

" CPP syntax ---------------------------

" Highlighting of class scope
let g:cpp_class_scope_highlight = 1

" Highlighting of member variables
let g:cpp_member_variable_highlight = 1

" Highlighting of class names
let g:cpp_class_decl_highlight = 1

" Highlighting of POSIX functions
let g:cpp_posix_standart = 0

" Highlighting of template functions
" let g:cpp_experimental_simple_template_highlight = 0
let g:cpp_experimental_template_highlight = 1

" Highlighting of library concepts
let g:cpp_concepts_highlight = 1

" NO Highlighting of user defined functions
let g:cpp_no_function_highlight = 0

" Code formatting ----------------------

"autocmd VimEnter * ":Glaive codefmt plugin[mappings]"

"augroup autoformat_settings
    "autocmd FileType bzl AutoFormatBuffer buildifier
    "autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    "autocmd FileType c,cpp,proto,javascript Glaive codefmt clang_format_style='{IndentWidth: 4}'
    "autocmd FileType dart AutoFormatBuffer dartfmt
    "autocmd FileType go AutoFormatBuffer gofmt
    "autocmd FileType gn AutoFormatBuffer gn
    "autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    "autocmd FileType java AutoFormatBuffer google-java-format
    "autocmd FileType python AutoFormatBuffer yapf
    "autocmd FileType python AutoFormatBuffer autopep8
    "autocmd FileType vue AutoFormatBuffer prettier
"augroup END

" Treesitter ---------------------------

lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

EOF

" Fugitive -----------------------------

nmap <leader>gh :diffget //3<CR>
nmap <leader>gl :diffget //2<CR>
nmap <leader>gs :G<CR>

" Live LaTeX preview -------------------

" FIXME problem with swallow dwm V
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'xelatex'
let g:livepreview_cursorhold_recompile = 0

" autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
"autocmd BufWritePost *.tex silent exec '!compiler '.shellescape('%')
autocmd BufWritePost *.tex AsyncRun compiler "%"

" LSP ----------------------------------

" Handled by CoC

"lua <<EOF
"vim.cmd('packadd nvim-lspconfig')
"require'nvim_lsp'.clangd.setup(name="clangd", settings = {},)
"EOF

"set hidden

"let g:LanguageClient_serverCommands = {
    "\ 'python': ['/usr/local/bin/pyls'],
    "\ 'cpp': ['clangd', '-background-index',],
    "\ }

" vim-dispatch -------------------------

" yes

" vim-snippets -------------------------

" Tab for autocompletion
" let g:UltiSnipsExpandTrigger="<tab>"

" " C-b for next autofill
" let g:UltiSnipsJumpForwardTrigger="<tab>" " <c-b>
" " FIXME
" " C-z for previous autofill
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>" " <c-z>

" Fold map -----------------------------

vnoremap <leader>f :fold<CR>

" Discord

" Handled by CoC

" let g:discord_activate_on_enter = 1
" let g:discord_rich_presence = 1
" g:discord_workspace = "Custom name of project" 

" CMake --------------------------------

let g:cmake_cxx_compiler='g++' " 'clang++'

" Vifm ---------------------------------

let g:vifm_replace_netrw = 1
let g:vifm_replace_netrw_cmd = "Vifm"
let g:vifm_embed_split=1
set splitbelow

" AsyncRun -----------------------------

" Open quickfix window automatically when AsyncRun is executed
" set the quickfix window 6 lines in height
"let g:asyncrun_open = 6

" Ring the bell to notify for finished job
"let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6) <CR>

" vim-rainbow --------------------------

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tux', [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['\v%(<operator\_s*)@<!%(%(\i|^\_s*|template\_s*)@<=\<[<#=]@!|\<@<!\<[[:space:]<#=]@!)', '\v%(-)@<!\>']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

"let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
"let g:rainbow_ctermfgs = ['white', 'red', 'lightblue', 'green'] " ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
"let g:rainbow_guifgs = ['green', 'yellow', 'magenta', 'pink', 'brown'] " TODO

" wal ----------------------------------

if using_neovim
    " `termguicolors` can mess up colorscheme
    " set notermguicolors
endif

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Goyo ---------------------------------

set mouse=a " FIXME

function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
    " ...
endfunction

function! s:goyo_leave()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Vimspector Debugger ------------------

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-go', 'vscode-bash-debug', 'vscode-java-debug', 'debugger-for-chrome' ]
"let g:vimspector_enable_mappings = 'HUMAN'V

" F5	            When debugging, continue. Otherwise start debugging.	    vimspector#Continue()
" F3	            Stop debugging.	                                            vimspector#Stop()
" F4	            Restart debugging with the same configuration.	            vimspector#Restart()
" F6	            Pause debugee.	                                            vimspector#Pause()
" F9	            Toggle line breakpoint on the current line.	                vimspector#ToggleBreakpoint()
" <leader>F9	    Toggle conditional line breakpoint on the current line.	    vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )
" F8	            Add a function breakpoint for the expression under cursor	vimspector#AddFunctionBreakpoint( '<cexpr>' )
" <leader>F8	    Run to Cursor	                                            vimspector#RunToCursor()
" F10	            Step Over	                                                vimspector#StepOver()
" F11	            Step Into	                                                vimspector#StepInto()
" F12	            Step out of current function scope	                        vimspector#StepOut()

nnoremap <leader>m :MaximizerToggle!<CR>
nmap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

noremap <leader>dk :!clear;echo;echo <C-r>=expand('%.r')<CR> \| xargs java<CR>
autocmd FileType java nnoremap <leader>dd :CocCommand java.debug.vimspector.start<CR>

function! JavaStartDebugCallback(err, port)
  execute "cexpr! 'Java debug started on port: " . a:port . "'"
  call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
endfunction

function JavaStartDebug()
  call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
endfunction

" nmap <F5> :call JavaStartDebug()<CR>
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" <Plug>VimspectorStop
" <Plug>VimspectorPause
" <Plug>VimspectorAddFunctionBreakpoint

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Markdown Live Preview ----------------

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

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" if using_neovim
"     let g:yankring_history_dir = '~/.config/nvim/'
"     " Fix for yankring and neovim problem when system has non-text things
"     " copied in clipboard
"     let g:yankring_clipboard_monitor = 0
" else
"     let g:yankring_history_dir = '~/.vim/dirs/'
" endif

" Molokai theme ------------------------

let g:molokai_original = 0
let g:rehash256 = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 1
" let g:airline_theme = 'wal' " 'deus' "'bubblegum'
let g:airline_theme = 'monokai_tasty'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!! ----------------------

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

" Custom configurations ----------------

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif
