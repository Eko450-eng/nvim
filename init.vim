source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/keybinds.vim

" let g:polyglot_disabled = ['org']

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeMapOpenDirNode = 'l'
let g:NERDTreeMapCloseDirNode = 'h'

" Enabling plugins
lua require"surround".setup{}

lua << EOF

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})



EOF

" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
