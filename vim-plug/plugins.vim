" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Adding a magit clone to Neovim
    Plug 'nvim-lua/plenary.nvim'
    Plug 'jreybert/vimagit'
    Plug 'sindrets/diffview.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " Plug 'cappyzawa/trim.nvim'
    " Plug 'Odie/gitabra'
    " Plug 'kdheepak/lazygit.nvim'

    " Theme
    Plug 'shaunsingh/nord.nvim'

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
