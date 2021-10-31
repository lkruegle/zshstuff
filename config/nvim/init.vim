syntax on

set autoread
set guicursor=
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set nu
set nowrap
set smartindent
set ignorecase
set smartcase
set incsearch
set hlsearch
set scrolloff=8
set signcolumn=yes " might not need this
set updatetime=50

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Pop up menu options TODO look into these
set cot=menuone,noinsert,noselect shm+=c

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
Plug 'preservim/nerdtree'
Plug 'f-person/git-blame.nvim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'lifepillar/vim-solarized8'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jremmen/vim-ripgrep'
Plug 'yassinebridi/vim-purpura'
Plug 'tpope/vim-abolish'
call plug#end()

set background=dark

colorscheme gruvbox

"Theses settings all make purpura work right
"colorscheme purpura
"set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

lua <<EOF
-- configure lsp
-- require('lspconfig').pyright.setup{}

-- configure treesitter
require('nvim-treesitter.configs').setup {
    highlight = {enable = true},
--    -- I want to add:
--    -- But it keeps dedenting methods as I add type info which is annoying as fuck
--    -- indent = {enable = true},
}
EOF

" Git blame message config
let g:gitblame_message_template = '<author> • <sha> • <date>'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
" end completion mappings


let mapleader = " "

" To force reparse current buffer to fix highlighting
nnoremap <leader>ts :write<CR> :edit<CR> :TSBufEnable highlight<CR>

"undotree mapping
nnoremap <leader>u :UndotreeToggle<CR>

" Make Y like D/C, yank to end of line
nnoremap Y y$

nnoremap <leader>gb :GitBlameToggle<CR>
nnoremap <leader>n :nohl<CR>

" Force n and N to always search forward and backwards respectively
" (zz keeps cursor centered)
nnoremap <expr> n 'Nn'[v:searchforward] . "zzzv"
nnoremap <expr> N 'nN'[v:searchforward] . "zzzv"

"Add undo break points at common characters
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u


" Keep cursor where it is when joining lines
nnoremap J mzJ`z

" Toggle Nerd Tree with CTRL +n
map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-f> <cmd>Telescope find_files<CR>
nnoremap <leader>tg <cmd>Telescope live_grep<CR>
nnoremap <leader>tb <cmd>Telescope buffers<CR>
nnoremap <leader>th <cmd>Telescope help_tags<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" Open a split
nnoremap <leader>vs :vsp<space>
nnoremap <leader>hs :sp<space>

" Remaps pane switching to CTRL+h,j,k,l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <leader>zz :let &scrolloff=999-&scrolloff<CR>

nnoremap <C-T> :tabnew<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <Tab> :tabnext<CR>

" Mappings for changing directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>ct :cd ~/code/catalant<CR>:pwd<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup GROUP_1
    autocmd BufWritePre * :call TrimWhitespace()
    "autocmd BufEnter * lua require'completion'.on_attach()
    autocmd BufNewFile,BufRead,BufEnter *.html set syntax=htmljinja
augroup END

