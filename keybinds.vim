" Change leader to space
let mapleader = "\<Space>"

" Enabling plugins
lua require"surround".setup{}

" NerdTree
nmap <silent> <C-E> :NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit="5" 
nnoremap  <leader>bo :Bookmark<CR>

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
nnoremap <M-j> <C-w>j
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

" Git
nnoremap  <leader>gg :Git<cr>
nnoremap  <leader>gd :DiffviewOpen<cr>
nnoremap  <leader>gD :DiffviewClose<cr>

" Comment box
nnoremap gc :CBlbox<CR>

" Tabbing

