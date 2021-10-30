" TODO: Port these to my vim repo or merge the two. Depends on https://github.com/lkruegle/personal_vim

set runtimepath+=~/.vim_runtime
set nowrap
set scrolloff=8
" set signcolumn=yes " enable when adding git integration
set nu
set relativenumber

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
execute pathogen#infect()

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

au BufReadPost *.html set syntax=jinja

let mapleader = " "
let NERDTreeQuitOnOpen=1

" these currently break new tab mapping
" nnoremap ; :
" nnoremap : ;

" enables Taglist
filetype on
map tlt :TlistToggle<CR>

nnoremap <S-Tab> :tabprev<CR>
inoremap <S-Tab> <C-d>

" Remaps pane switching to CTRL+h,j,k,l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <leader>zz :let &scrolloff=999-&scrolloff<CR>

" Toggle NERD Tree with CTRL+n
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>n :noh <return><esc>
nnoremap <leader>s :vsp<space>

set foldlevel=99
