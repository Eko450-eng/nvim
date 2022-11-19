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

    " Comments
    Plug 'LudoPinelli/comment-box.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'godlygeek/tabular'

    " Themes
    Plug 'shaunsingh/nord.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Mofiqul/dracula.nvim'
    Plug 'norcalli/nvim-colorizer.lua'

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

    "Newly added
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'MunifTanjim/prettier.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'akinsho/bufferline.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'dinhhuy258/git.nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'iamcco/markdown-preview.nvim'

    Plug 'lambdalisue/suda.vim'
    Plug 'xiyaowong/nvim-transparent'
    Plug 'elkowar/yuck.vim'

    
    call plug#end()
