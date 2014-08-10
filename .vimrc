set hlsearch
set incsearch
syntax on
set ts=4
set cindent
set smartindent
set autoindent
set shiftwidth=2
set expandtab
set ls=2
set nu
set updatetime=200
set splitright
set splitbelow

" VUNDLE 
set nocompatible
filetype off " Required for Vundle, turn it back on later

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle with Vundle 
Plugin 'gmarik/Vundle.vim'

" Editor helpers
Plugin 'AutoComplPop'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'

" File navigation
" Plugin 'yegappan/mru'  " Using CtrlP MRU now
Plugin 'kien/ctrlp.vim'

" Colors 
Plugin 'tomasr/molokai'

" syntax
Plugin 'puppetlabs/puppet-syntax-vim'

call vundle#end()
filetype plugin indent on
" VUNDLE END

" Color settings. Can also be done with export 'TERM=xterm-256color'
set t_Co=256
colorscheme molokai

" Current line settings
set cursorline

" Custom maps
"nnoremap <C-e> :MRU<CR>
nnoremap <C-e> :CtrlPMRU<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>


" Remember what line we were on
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

" Add airline tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 " Requires the fonts-powerline package
