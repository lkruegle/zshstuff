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

" Auto Install VimPlug and all plugins on startup
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: Setup hrsh7th/nvim-cmp configuration

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Add after downloading a font from nerdfonts.com
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ThePrimeagen/harpoon'
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
Plug 'tpope/vim-abolish'
Plug 'akinsho/toggleterm.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'Glench/Vim-Jinja2-Syntax'
call plug#end()

set background=dark
colorscheme gruvbox


lua <<EOF
-- configure lsp
-- require('lspconfig').pyright.setup({})

-- configure treesitter
require('nvim-treesitter.configs').setup({
    -- Remember to 'TSInstall <language>'
    highlight = {enable = true},
--    -- I want to add:
--    -- But it keeps dedenting methods as I add type info which is annoying as fuck
--    -- indent = {enable = true},
})

-- configure toggleterm
require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    start_in_insert = true,
    close_on_exit = true,
    direction = 'float',
    shading_factory = 2,
    float_opts = {
        border = 'curved',
        width = math.min(math.floor(vim.api.nvim_win_get_width(0) / 2), 200),
        highlights = {
            border = "Normal",
            background = "Normal"
        },
    }
})

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("gitsigns").setup({})

require("nvim-web-devicons").setup({})
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

" undotree mapping *currently shadowed by harpoon mappings
" nnoremap <leader>u :UndotreeToggle<CR>

" Make Y like D/C, yank to end of line
nnoremap Y y$

nnoremap <leader>gb :GitBlameToggle<CR>
nnoremap <leader>n :nohl<CR>

nnoremap <leader>ss /<C-r><C-w><CR>
nnoremap <leader>sr :%s/<C-r><C-w>/
" Force n and N to always search forward and backwards respectively
" (zz keeps cursor centered)
nnoremap <expr> n 'Nn'[v:searchforward] . "zzzv"
nnoremap <expr> N 'nN'[v:searchforward] . "zzzv"

lua <<EOF
local map = vim.api.nvim_set_keymap
-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables

options = { noremap = true }

undo_breaks = {',','.','(',')','{','}','[',']'}
for i, char in ipairs(undo_breaks) do
    map('i', char, string.format('%s<c-g>u', char), options)
end

-- configure Harpoon
require('harpoon').setup({
    menu = { width = math.max(math.floor(vim.api.nvim_win_get_width(0) / 3), 60) }
})

map('n', '<leader>h', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', options)
map('n', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>', options)

-- Loop through and set these to harpoon marks in order
map_keys = {'u', 'i', 'o', 'p'}
for count, key in ipairs(map_keys) do
    remap = string.format('<leader>%s', map_keys[count])
    command = string.format(':lua require("harpoon.ui").nav_file(%s)<CR>', count)
    map('n', remap, command, options)
end

local actions = require "telescope.actions"
require("telescope").setup {
    file_ignore_patterns = {
        '%/static/vendor/%'
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                ["<c-d>"] = actions.delete_buffer
                }
            }
        }
    }
}
EOF


" Keep cursor where it is when joining lines
nnoremap J mzJ`z

" Toggle Nerd Tree with CTRL +n
" map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-f> <cmd>Telescope git_files<CR>
nnoremap <leader>tg <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>th <cmd>Telescope help_tags<CR>
nnoremap <leader>gg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" Remaps pane switching to CTRL+h,j,k,l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <leader>zz :let &scrolloff=999-&scrolloff<CR>

" Tab stuff
nnoremap <C-T> :tabnew<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <Tab> :tabnext<CR>

" Mappings for changing directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>ct :cd ~/code/catalant<CR>:pwd<CR>

" Mappings for navigating quick-fix list
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>


" Replace with sbdchd/neoformat
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup GROUP_1
    autocmd BufWritePre * :call TrimWhitespace()
    "autocmd BufEnter * lua require'completion'.on_attach()
    "autocmd BufNewFile,BufRead,BufEnter *.html set syntax=htmljinja
augroup END
