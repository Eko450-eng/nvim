source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/keybinds.vim
source $HOME/.config/nvim/configs/nerdtree.vim
source $HOME/.config/nvim/configs/plugins.vim
source $HOME/.config/nvim/configs/theming.vim

" Default settings
"
let g:neovide_transparency = 0.8
let g:neovide_opacity = 0.8
let g:neovide_window_floating_opacity = 0.2
let g:neovide_window_floating_transparency = 0.2
let g:neovide_floating_blur = 0
let g:neovide_window_floating_blur = 0

set clipboard+=unnamedplus
set number
set mouse=a
set wildchar=<TAB>
set ignorecase

autocmd VimEnter * NERDTree /home/eko/.config/nvim
