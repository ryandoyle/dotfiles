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
set backspace=2

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
"Plugin 'lifepillar/vim-mucomplete'
"set completeopt+=menuone,noinsert,popup
"let g:mucomplete#enable_auto_at_startup = 1

"Plugin 'dense-analysis/ale'  " Linter
Plugin 'prabirshrestha/vim-lsp'
let g:lsp_diagnostics_echo_cursor = 1 " print gutter messages for errors/warnings
"let g:lsp_float_max_width = 0 " Doesn't seem to do anything
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " Custom toggling
    call lsp#disable_diagnostics_for_buffer()
    let g:my_lsp_diagnostics_enabled = 0
    
endfunction
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" START toggle diagnstics
let g:my_lsp_diagnostics_enabled = 1

" From https://github.com/prabirshrestha/vim-lsp/issues/1312
function s:MyToggleLSPDiagnostics()
    if g:my_lsp_diagnostics_enabled == 1
        call lsp#disable_diagnostics_for_buffer()
        let g:my_lsp_diagnostics_enabled = 0
        echo "LSP Diagnostics : off"
    else
        call lsp#enable_diagnostics_for_buffer()
        let g:my_lsp_diagnostics_enabled = 1
        echo "LSP Diagnostics : on"
    endif
endfunction

command MyToggleLSPDiagnostics call s:MyToggleLSPDiagnostics()
nnoremap <F12> :MyToggleLSPDiagnostics<CR>
" END toggle diagnostics

Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-buffer.vim' "doenst work
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': [''],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-expand-region'
Plugin 'ryandoyle/HiCursorWords'

" File navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'

" Colors 
Plugin 'tomasr/molokai'

" Language plugins
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'justinmk/vim-syntax-extra'

" Framework helpers 
Plugin 'janko-m/vim-test'

call vundle#end()
filetype plugin indent on

" Color settings. Can also be done with export 'TERM=xterm-256color'
set t_Co=256
colorscheme molokai

" Over-ride the current setting for paren matching
hi MatchParen      ctermfg=253  ctermbg=236 cterm=bold
hi UnderCursor     ctermbg=18
hi Search          ctermfg=253 ctermbg=21 

" Current line settings
set cursorline

" Custom maps
nnoremap <C-e> :CtrlPMRU<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <C-f> :Ag<SPACE>
nnoremap <silent> <C-S-F10> :TestFile<CR>

" Remember what line we were on
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

" Add airline tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the title
let g:airline_theme='simple'

" Highlight cursor settings
let g:HiCursorWords_delay = 10

let g:ctrlp_max_height = 20
let g:ctrlp_root_markers = ['.ctrlp']

