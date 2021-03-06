" Change leader to space
let mapleader = "\<Space>"

" Enabling plugins
lua require"surround".setup{}

" Rebind NERDTreeToggle
nmap <silent> <C-E> :NERDTreeToggle<CR>
" Open Vertical Split
let NERDTreeMapOpenVSplit="5" 

" Source vimrc
nnoremap <LEADER>sv :source $MYVIMRC<CR>

" Leader key functions to mimic emacs saving and closing buffer
nnoremap <LEADER>fs :write<CR>
nnoremap <LEADER>bd :quit<CR>

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

" Use <c-space> to trigger completion.
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ kite#completion#autocomplete()

nnoremap  <leader>gg :MagitOnly<cr>
nnoremap  <leader>gd :DiffviewOpen<cr>
nnoremap  <leader>gD :DiffviewClose<cr>
