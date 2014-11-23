set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'

let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_compiler_options = ' -ansi -pedantic'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -pedantic'

call vundle#end()
filetype plugin indent on
filetype plugin on

syntax on
set backspace=indent,eol,start
set number
set ruler
set showcmd
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set ignorecase
set smartcase
set showmatch

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
