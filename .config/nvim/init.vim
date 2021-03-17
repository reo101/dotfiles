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

Plug 'arielrossanigo/dir-configs-override.vim'      " Override configs by directory with a `.vim.custom` rc file
"Plug 'scrooloose/nerdcommenter'                    " Old code commenter
Plug 'tpope/vim-commentary'                         " Code commenter TODO learn hotkeys
" Plug 'scrooloose/nerdtree'                        " Old file browser
Plug 'vifm/vifm.vim'                                " Better file browser TODO learn hotkeys 
Plug 'wellle/targets.vim'                           " Better targets ci( from beggining of line
Plug 'majutsushi/tagbar'                            " Class/module browser Uses `tags` but not required
Plug 'vim-scripts/IndexedSearch'                    " Search results counter At match #N out of matches
Plug 'fisadev/fisa-vim-colorscheme'                 " Colorschemes
Plug 'patstockwell/vim-monokai-tasty'               " Colorschemes
Plug 'Reewr/vim-monokai-phoenix'                    " Colorschemes
Plug 'tomasr/molokai'                               " Colorschemes
Plug 'vim-airline/vim-airline'                      " Airline 
Plug 'vim-airline/vim-airline-themes'               " Airline themes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Code and files fuzzy finder
Plug 'junegunn/fzf.vim'                             " fzf plugin TODO learn hotkeys
Plug 'fisadev/FixedTaskList.vim'                    " Pending tasks list TODO and FIXME lookup
Plug 'Shougo/context_filetype.vim'                  " Completion from other opened files
Plug 'jiangmiao/auto-pairs'                         " Autoclose
Plug 'tpope/vim-surround'                           " Text obejcts surrounding TODO learn hotkeys 
Plug 'tpope/vim-repeat'                             " vim-repeat Repeat more complex actions with `.`, used by vim-surround
Plug 'michaeljsmith/vim-indent-object'              " Indent text object Defines text objects for identetions (Python) TODO learn hotkeys 
Plug 'jeetsukumaran/vim-indentwise'                 " Indentation based movements Keymaps to jump between indents TODO learn hotkeys
Plug 'sheerun/vim-polyglot'                         " Vast language syntax highlighting and indentation
Plug 'mileszs/ack.vim'                              " Ack code search TODO see `:help Ack` 
Plug 'RRethy/vim-hexokinase'                        " Paint css colors with the real color
Plug 't9md/vim-choosewin'                           " Window chooser Press `-`* to select vim window to focus TODO learn hotkeys 
Plug 'valloric/MatchTagAlways'                      " Highlight matching html tags
Plug 'mattn/emmet-vim'                              " Generate html in a simple way TODO learn syntax 
Plug 'tpope/vim-fugitive'                           " Git integration
Plug 'tpope/vim-rhubarb'                            " :GBrowse for GitHub
Plug 'shumphrey/fugitive-gitlab.vim'                " :GBrowse ofr GitLab
Plug 'mhinz/vim-signify'                            " Git (and other) diff icons on the side of the file lines
Plug 'neomake/neomake'                              " Automated and better `:make` TODO see `:help neomake.txt`
Plug 'ryanoasis/vim-devicons'                       " Nice icons in the file explorer and file type status line.
" Plug 'SirVer/ultisnips'                           " ultisnips - currently writing my own
" Plug 'honza/vim-snippets'                         " vim-snippets
Plug 'dylanaraps/wal.vim'                           " wal
Plug 'skywind3000/asyncrun.vim'                     " asyncrun TODO learn commands
Plug 'junegunn/goyo.vim'                            " Goyo - vim zen mode
Plug 'junegunn/limelight.vim'                       " Only highlights the current paragraph (combo with Goyo)
Plug 'puremourning/vimspector'                      " Rich graphical debugger TODO lots of config, replace by nvim-dap
Plug 'szw/vim-maximizer'                            " Windows maximizer Basically Ctrl+w o
Plug 'wakatime/vim-wakatime'                        " Wakatime - Counts time spent per project
Plug 'lervag/vimtex'                                " vimtex - LaTeX integration
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " Live LaTeX compilation and preview TODO replace with normal auto compilation
Plug 'kevinoid/vim-jsonc'                           " Json with comments
Plug 'vimwiki/vimwiki'                              " VimWiki - personal wiki (im using it with markdown)
Plug 'christoomey/vim-tmux-navigator'               " tmux integration
Plug 'edkolev/tmuxline.vim'                         " tmux airline integration
if using_neovim
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}} " Async autocompletion
    Plug 'nvim-treesitter/nvim-treesitter'          " Treesitter for syntax highlighting
    Plug 'nvim-treesitter/playground'               " Playground for treesitter, used when creating things
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] } " Markdown Live Preview
endif

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ======================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ======================================
" Vim settings and mappings

source $HOME/.config/nvim/settings/general.vim          " General

" ======================================
" Plugins settings and mappings

source $HOME/.config/nvim/plug-config/tagbar.vim        " Tagbar
source $HOME/.config/nvim/plug-config/nerdtree.vim      " NERDTree
source $HOME/.config/nvim/plug-config/tasklist.vim      " TaskList
source $HOME/.config/nvim/plug-config/neomake.vim       " Neomake
source $HOME/.config/nvim/plug-config/fzf.vim           " FZF
source $HOME/.config/nvim/plug-config/coc.vim           " CoC
source $HOME/.config/nvim/plug-config/vimwiki.vim       " VimWiki
source $HOME/.config/nvim/plug-config/treesitter.vim    " Treesitter
source $HOME/.config/nvim/plug-config/fugitive.vim      " Fugitive
source $HOME/.config/nvim/plug-config/latexlive.vim     " LaTeX live
" source $HOME/.config/nvim/plug-config/lsp.vim         " LSP (soon)
" source $HOME/.config/nvim/plug-config/snippets.vim    " Snippets
source $HOME/.config/nvim/plug-config/vifm.vim          " Vifm
source $HOME/.config/nvim/plug-config/asyncrun.vim      " AsyncRun
" source $HOME/.config/nvim/plug-config/rainbow.vim     " Rainbow 
" source $HOME/.config/nvim/plug-config/ack.vim         " Ack
source $HOME/.config/nvim/plug-config/goyo.vim          " Goyo
source $HOME/.config/nvim/plug-config/vimspector.vim    " Vimspector
source $HOME/.config/nvim/plug-config/winchoose.vim     " Window chooser
source $HOME/.config/nvim/plug-config/mdlive.vim        " MD live
source $HOME/.config/nvim/plug-config/signify.vim       " Signify
source $HOME/.config/nvim/plug-config/airline.vim       " Airline
source $HOME/.config/nvim/plug-config/tmux.vim          " Tmux
source $HOME/.config/nvim/plug-config/tmuxline.vim      " Tmux Airline

" KEYBINDS
vnoremap <leader>f :fold<CR>

" SETTINGS

" Molokai theme ------------------------

let g:molokai_original = 0
let g:rehash256 = 1

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
