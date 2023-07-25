set nocompatible
filetype off
filetype plugin indent on

syntax enable
highlight Visual cterm=bold ctermfg=Black

set number
set tabstop=2 shiftwidth=2 softtabstop=2
set printoptions=number:y
set cindent
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
set encoding=utf-8

let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

au BufRead,BufNewFile *.ptx setfiletype asm

autocmd Filetype make setlocal noexpandtab

nnoremap t gt
nnoremap T gT
ca tn tabnew
