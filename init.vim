source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/keybinds.vim

set clipboard+=unnamedplus
set number
set mouse=a

" Setting default colorscheme
colorscheme nord

" For powerline fonts
let g:powerline_loaded = 1
let g:airline_powerline_fonts = 1

" NerdTree Config
let NERDTreeShowHidden = 1
let g:NERDTreeMapOpenDirNode = 'l'
let g:NERDTreeMapCloseDirNode = 'h'

" Enabling plugins
lua require"surround".setup{}

" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
