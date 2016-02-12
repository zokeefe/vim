set nocompatible				" Vi iMproved

" Plugins {{{

filetype off					" Required, plugins available after

if has("win32") || has("win64")
	set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
	call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()
filetype plugin indent on		" Required, plugins available after

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
"set number						" show line numbers
set nonumber					" hide line numbers
set ruler						" show cursor position in status bar
set showcmd						" show typed command in status bar
set ignorecase					" case insensitive searching
set smartcase					" case sensitive when uppercase typed
set showmatch					" show matching bracket
set wildmenu					" completion with menu
set laststatus=2				" use 2 lines for status bar
set lazyredraw					" redraw only when we need to
set fillchars+=vert:\ 			" remove '|' character in vsplit line
"set cursorline					" show cursor line (shown via autocmd now)
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
set tabstop=4					" number of visual spaces per tab 
"set softtabstop=4				" number of spaces in tab when editingn
set noexpandtab
" }}}
" Font {{{

set guifont=Liberation\ Mono\ Regular:h11

" }}}
" Colors {{{

syntax enable
colorscheme cmuratori

highlight clear Todo
highlight BAD ctermfg=Red guifg=Red gui=bold,underline
highlight IMPORTANT ctermfg=Yellow guifg=Yellow gui=bold,underline
highlight OK ctermfg=DarkGreen guifg=DarkGreen gui=bold,underline
highlight INTERESTING ctermfg=LightBlue guifg=LightBlue gui=bold,underline


" }}}
" Autogroups {{{
if has("autocmd")
  if v:version > 701

	" Highlighting keywords
    autocmd Syntax * call matchadd('BAD', '\W\zs\(TODO\)')
    autocmd Syntax * call matchadd('IMPORTANT', '\W\zs\(IMPORTANT\)')
    autocmd Syntax * call matchadd('OK', '\W\zs\(NOTE\)')
    autocmd Syntax * call matchadd('INTERESTING', '\W\zs\(IDEA\|STUDY\)')

	" Automatically open, but don't go to, Quickfix window
	autocmd QUickFixCmdPost [^l]* nested copen
	autocmd QUickFixCmdPost l* nested lopen

	" Automatically move Quickfix window to span bottom
	autocmd Filetype qf wincmd J

	" Show cursorline in current window only
	augroup CursorLine
		au!
		au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
		au WinLeave * setlocal nocursorline
	augroup END

	" VSplit window on startup
	"autocmd VimEnter * vsplit

	" Try to prvent bell and screen flash
	autocmd GUIEnter * set vb t_vb= " for your GUI
	autocmd VimEnter * set vb t_vb=

  endif
endif
" }}}
" Leader shortcuts {{{
let g:mapleader=","

" Make
nmap <Leader>b :make<CR>

" Swapping windows
"nmap <Leader>s :wincmd r<CR>

" }}}
" Keybindings {{{

" Moving between windows
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Swapping  windows
nmap <silent> <c-s> :wincmd r<CR>

" Quickfix errors
nmap <silent> <c-n> :cn<CR>
nmap <silent> <c-m> :cp<CR>
nmap <silent> <c-space> :ccl<CR>

" Workaround for console vim on OS X Terminal.app
noremap <NUL> :ccl<CR>

" }}}
" Backups {{{
set backup
if has("win32") || has("win64")
	set backupdir=~/vimfiles/backup
	set directory=~/vimfiles/tmp
else
	set backupdir=~/.vim/backup
	set directory=~/.vim/tmp
endif
set writebackup
" }}}
" Custom Functions {{{

" }}}
" Misc. {{{

set visualbell					" enable vim's internal visual bell
set t_vb=						" set vim's internal bell to do nothing
set guicursor=a:blinkon600-blinkoff400  " Slow down cursor blinking speed
if has("gui_running")
	set guioptions-=L			" remove macvim left scrollbar
	set guioptions-=R			" remove macvim right scrollbar
	set guioptions-=l			" remove macvim left scrollbar extra
	set guioptions-=r			" remove macvim right scrollbar extra
	set guioptions-=m			" remove gvim menu 
	set guioptions-=T			" remove gvim toolbar 
endif
if has("gui_macvim")			" set macvim specific stuff
	let macvim_skip_colorscheme=1
	set lines=999 columns=999	" start fullscreen
endif
if has("win32") || has("win64")
	au GUIEnter * simalt ~x
endif
" }}}
" External configuration {{{
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif
" }}}
" Compilation {{{
"
set makeprg=sh\ build.sh

" }}}

" vim:foldmethod=marker:foldlevel=0
