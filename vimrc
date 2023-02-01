set nocompatible
filetype off
filetype plugin indent on

syntax on
highlight Visual cterm=bold ctermfg=Black

set number
set printoptions=number:y
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set laststatus=2
set backspace=indent,eol,start
set hlsearch
set incsearch
set smartcase
set nobackup
set noswapfile
set noshowmatch
set noshowmode
set tw=0

autocmd Filetype make setlocal noexpandtab

nnoremap t gt
nnoremap T gT
ca tn tabnew
