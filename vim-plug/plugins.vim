" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Adding a magit clone to Neovim
    Plug 'jreybert/vimagit'
    Plug 'sindrets/diffview.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'nvim-lua/plenary.nvim'

    " Org Mode
    Plug 'nvim-orgmode/orgmode'

    " Themes
    Plug 'shaunsingh/nord.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Mofiqul/dracula.nvim'

    " Enable surround mod
    Plug 'ur4ltz/surround.nvim'

    " Language support for TS 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " File Explorer
    Plug 'scrooloose/NERDTree'

    " Blockcomments
    Plug 'thomas-glaessle/vim-blockcomment'
    Plug 'flw-cn/vim-nerdtree-l-open-h-close'

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

call plug#end()
