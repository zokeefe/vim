set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-unimpaired'
"Plugin 'jerrymarino/xcodebuild.vim'
Plugin 'tpope/vim-dispatch'

"let g:syntastic_c_compiler = 'clang'
"let g:syntastic_c_compiler_options = ' -ansi -pedantic'
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -pedantic'

"let g:ycm_confirm_extra_conf = 0
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"let g:ycm_extra_conf_vim_data = ['&filetype']

call vundle#end()
filetype plugin indent on
filetype plugin on

compiler xcodebuild 

syntax on
let g:mapleader=","
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
set wildmenu
set incsearch
set hlsearch
set laststatus=2

highlight clear Todo
highlight BAD ctermfg=Red guifg=Red
highlight WARN ctermfg=Yellow guifg=Yellow
highlight OK ctermfg=Green guifg=Green
highlight INTERESTING ctermfg=LightBlue guifg=LightBlue

if has("autocmd")
  if v:version > 701
    autocmd Syntax * call matchadd('BAD', '\W\zs\(TODO\|BUG\)')
    autocmd Syntax * call matchadd('WARN', '\W\zs\(HACK\|IMPORTANT\)')
    autocmd Syntax * call matchadd('OK', '\W\zs\(NOTE\)')
    autocmd Syntax * call matchadd('INTERESTING', '\W\zs\(IDEA\)')
  endif
endif

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <Leader>b :Make<CR>

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow
