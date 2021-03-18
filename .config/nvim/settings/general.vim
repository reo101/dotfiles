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
    set splitright " splitbelow
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

" Enable full mouse control
set mouse=a " FIXME

" remove ugly vertical lines on window division
" important ' ' at the end!!!
set fillchars-=vert:\| | set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|xterm-256color\|screen-256\|st\|st-256\|st-256color')
    if !has('gui_running')
        set termguicolors
        " colorscheme vim-monokai-tasty " wal
        let &t_Co = 256
    endif

    " if (&term =~? 'st\|st-256\|st-256color') && using_vim
    "     set term=xterm-256color
    "     set notermguicolors
    "     " set term=st-256color
    "     autocmd VimEnter * set term=st-256color
    "     set termguicolors
    " endif
   
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
    colorscheme delek
endif

" set colorscheme
colorscheme monokai-phoenix

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=longest:full,full

" save as sudo
ca w!! w !sudo tee "%"

" buffer navigation mappings
map tt :enew<CR> 
map <M-Right> :bnext<CR>
imap <M-Right> <ESC>:bnext<CR>
map <M-Left> :bprevious<CR>
imap <M-Left> <ESC>:bprevious<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Conceal words if not in insert ot VB mode
set concealcursor="nc"
set conceallevel=2

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
