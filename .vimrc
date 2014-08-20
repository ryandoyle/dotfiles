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
set lazyredraw " Faster scrolling
set hidden " Hide buffers instead of asking to save them when chaning buffers

" Use ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

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
Plugin 'tpope/vim-fugitive'
Plugin 'taglist.vim'

" File navigation
" Plugin 'yegappan/mru'  " Using CtrlP MRU now
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'

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
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>
nnoremap <F4> :TlistToggle<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <C-f> :Ag<SPACE>
"nnoremap <C-[> :pop<CR>

" Remember what line we were on
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

" Add airline tab bar
let g:airline#extensions#tabline#enabled = 1

" Config for taglist
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
