source $HOME/.config/nvim/vim-plug/plugins.vim
" source ./keybinds.vim

set clipboard+=unnamedplus
set number
set mouse=a

" Setting default colorscheme
colorscheme nord

" Change leader to space
let mapleader = "\<Space>"

" For powerline fonts
let g:powerline_loaded = 1
let g:airline_powerline_fonts = 1

" Enabling plugins
lua require"surround".setup{}
lua require"neogit".setup{}

" NerdTree Config
let NERDTreeShowHidden = 1
let g:NERDTreeMapOpenDirNode = 'l'
let g:NERDTreeMapCloseDirNode = 'h'
nmap <silent> <C-E> :NERDTreeToggle<CR>

" Source vimrc
nnoremap <LEADER>sv :source $MYVIMRC<CR>

" Leader key functions to mimic emacs saving and closing buffer
nnoremap <LEADER>fs :write<CR>
nnoremap <LEADER>bd :quit<CR>

" Open Vertical Split
let NERDTreeMapOpenVSplit="5" 

" Swap window positions
nnoremap <C-w>j <C-w>r
nnoremap <C-w>k <C-w>r
nnoremap <C-w>h <C-w>s
nnoremap <C-w>l <C-w>s

" Resize window
nnoremap <C-w>j <C-w>r
nnoremap <C-w>k <C-w>r
nnoremap <C-w>h <C-w>s
nnoremap <C-w>l <C-w>s

" Move window
nnoremap <M-h> <C-w>h
noremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
