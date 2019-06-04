set nocompatible
set number
set term=screen-256color
set background=dark
filetype off
set hlsearch
set smartcase
set ignorecase
set incsearch
set smarttab
set rtp+=~/.vim/bundle/vundle/
set ruler
call vundle#rc()
set tabstop=4 
set shiftwidth=4 
set expandtab
syntax enable
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'	
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
let g:lightline = {}
set laststatus=2
set noshowmode 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:gitgutter_max_signs = 500
set splitbelow
set splitright
set foldmethod=indent
set foldlevel=99
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
set clipboard=unnamed

