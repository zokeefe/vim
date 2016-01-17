set nocompatible				" Vi iMproved

" Plugins {{{
filetype off					" Required during Vundle launch
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()
" }}}
" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Nearest ancestor of the current file containing either .git, .hg, .svn,
" .bzr, or other root markers
let g:ctrlp_working_path_mode = 'ra'
" }}}
" Enable filetype plugins {{{
filetype plugin on
filetype indent on
" }}}
" UI {{{
set number						" show line numbers
set ruler						" show cursor position in status bar
set showcmd						" show typed command in status bar
set ignorecase					" case insensitive searching
set smartcase					" case sensitive when uppercase typed
set showmatch					" show matching bracket
set wildmenu					" completion with menu
set laststatus=2				" use 2 lines for status bar
set lazyredraw					" redraw only when we need to
"set cursorline
" }}}
" Folding {{{
set foldenable					" enable folding
set foldlevelstart=99			" open all folds
set foldnestmax=10				" 10 nested folds
set foldmethod=indent			" fold based on indent level
" }}}
" Searching settings {{{
set incsearch					" show search matches during typing
set hlsearch					" highligh searches
" }}}
" Editor settings {{{
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent					" copy indent from current line when starting new line
set shiftwidth=4				" spaces for autoindents
set tabstop=4					" umber of visual spaces per tab 
set softtabstop=4				" number of spaces in tab when editingn
" }}}
" Colors {{{
syntax enable
highlight Search cterm=bold ctermfg=darkred ctermbg=yellow

highlight clear Todo
highlight BAD ctermfg=Red guifg=Red
highlight WARN ctermfg=Yellow guifg=Yellow
highlight OK ctermfg=Green guifg=Green
highlight INTERESTING ctermfg=LightBlue guifg=LightBlue

if has("gui_running")
	highlight Normal guifg=grey guibg=#251625
endif
let macvim_skip_colorscheme=1
" }}}
" Autogroups {{{
if has("autocmd")
  if v:version > 701

	" Highlighting keywords
    autocmd Syntax * call matchadd('BAD', '\W\zs\(TODO\|BUG\)')
    autocmd Syntax * call matchadd('WARN', '\W\zs\(HACK\|IMPORTANT\|WARNING\)')
    autocmd Syntax * call matchadd('OK', '\W\zs\(NOTE\)')
    autocmd Syntax * call matchadd('INTERESTING', '\W\zs\(IDEA\)')

	" Automatically open, but don't go to, Quickfix window
	autocmd QUickFixCmdPost [^l]* nested copen
	autocmd QUickFixCmdPost l* nested lopen

	" Automatically move Quickfix window to span bottom
	autocmd Filetype qf wincmd J

  endif
endif
" }}}
" Leader shortcuts {{{
let g:mapleader=","
nmap <Leader>b :make<CR>			
nmap <Leader>b! :make!<CR>			
" }}}
" Keybindings {{{
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <silent> <c-]> :cn<CR>
nmap <silent> <c-[> :cp<CR>
nmap <silent> <c-\> :ccl<CR>
" }}}
" System settings {{{
compiler xcodebuild 
" }}}
" Backups {{{
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set writebackup
" }}}
" Custom Functions {{{
" }}}
" Misc. {{{
set visualbell					" enable vim's internal visual bell
set t_vb=						" set vim's internal bell to do nothing
" }}}
" External configuration {{{
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
