" Set session file directory
let g:startify_session_dir = '~/.config/nvim/session'

" Set startify lists
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']    },
          \ { 'type': 'files',     'header': ['   Files']       },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']   },
          \ ]

" Set bookmarks
let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'p': '~/Projects/' },
            \ { 'z': '~/.zshrc' },
            \ ]

" Autoload Session.vim from cur dir
let g:startify_session_autoload = 1

" Trace back to .git when listing cwd
let g:startify_change_to_vcs_root = 1

" Enable Unicode support
let g:startify_fortune_use_unicode = 1

" Automatically update sessions
let g:startify_session_persistence = 1

" Remove empty buffers in session om quit
let g:startify_enable_special = 0

" Set header (default is cowsay with quotes)
let g:startify_custom_header = [
            \ '      ___           ___           ___                                       ___     ',
            \ '     /__/\         /  /\         /  /\             ___        ___          /__/\    ',
            \ '     \  \:\       /  /:/_       /  /::\           /__/\      /  /\        |  |::\   ',
            \ '      \  \:\     /  /:/ /\     /  /:/\:\          \  \:\    /  /:/        |  |:|:\  ',
            \ '  _____\__\:\   /  /:/ /:/_   /  /:/  \:\          \  \:\  /__/::\      __|__|:|\:\ ',
            \ ' /__/::::::::\ /__/:/ /:/ /\ /__/:/ \__\:\     ___  \__\:\ \__\/\:\__  /__/::::| \:\',
            \ ' \  \:\~~\~~\/ \  \:\/:/ /:/ \  \:\ /  /:/    /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/',
            \ '  \  \:\  ~~~   \  \::/ /:/   \  \:\  /:/     \  \:\|  |:|     \__\::/  \  \:\      ',
            \ '   \  \:\        \  \:\/:/     \  \:\/:/       \  \:\__|:|     /__/:/    \  \:\     ',
            \ '    \  \:\        \  \::/       \  \::/         \__\::::/      \__\/      \  \:\    ',
            \ '     \__\/         \__\/         \__\/              ~~~~                   \__\/    ',
            \]
