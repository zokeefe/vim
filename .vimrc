set nocompatible				" Vi iMproved

" Environment {{{

let g:is_windows = 0
if has("win32") || has("win64")
	let g:is_windows = 1
endif

let g:project_uni = 1
let g:project = g:project_uni

"}}}
" Environment variables {{{
if g:is_windows
	let $ZVIMRC = '$USERPROFILE/vimfiles/.vimrc'
else
	let $ZVIMRC = '~/.vim/.vimrc'
endif
" }}}
" Plugins {{{

filetype off					" Required, plugins available after

if g:is_windows 
	set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim/
	call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'mtth/scratch.vim'
Plugin 'rking/ag.vim'
"Plugin 'incsearch.vim'
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'ap/vim-buftabline'

call vundle#end()
filetype plugin indent on		" Required, plugins available after

" }}}
" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Nearest ancestor of the current file containing either .git, .hg, .svn,
" .bzr, or other root markers
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_depth = 20
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'
" let g:ctrlp_use_caching = 0

if g:is_windows
	" dir is faster then ag on windows
	" won't work with wildignore!
	" TODO(zach): We should try to use Everything (es) to do this
	" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d' 
endif

" }}}
" Incsearch {{{
"map /  <Plug>(incsearch-forward)
"let g:incsearch#auto_nohlsearch = 1
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)
" }}}
" FSwitch {{{
au! BufEnter *.c let b:fswitchst = 'h,h'
au! BufEnter *.cpp let b:fswitchst = 'hpp,h'
au! BufEnter *.m let b:fswitchst = 'h'
au! BufEnter *.hpp let b:fswitchst = 'cpp'
au! BufEnter *.h let b:fswitchst = 'c,cpp,m'
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
set completeopt=menuone,preview " preview window always show prototype
"set cursorline					" show cursor line
" }}}
" Editor settings {{{
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent					" copy indent from current line when starting new line
set shiftwidth=4				" spaces for autoindents
set tabstop=4					" number of visual spaces per tab
"set softtabstop=4				" number of spaces in tab when editing
set noexpandtab
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

if g:project == g:project_uni
	set wildignore+=*/data/*,*/bin/*,*/lynx_proto/*,*/prototype/*,*/sharpmake/*,*/projects/*
endif

" }}}
" Font {{{

if g:is_windows
	set guifont=Liberation_Mono:h10
else
	set guifont=Liberation\ Mono\ Regular:h11
endif

" }}}
" Colors {{{

if !has("gui_running") && g:is_windows
	syntax off
else
	syntax enable
	colorscheme cmuratori

	highlight clear Todo
	highlight BAD ctermfg=Red guifg=Red gui=bold,underline
	highlight IMPORTANT ctermfg=Yellow guifg=Yellow gui=bold,underline
	highlight OK ctermfg=DarkGreen guifg=DarkGreen gui=bold,underline
	highlight INTERESTING ctermfg=LightBlue guifg=LightBlue gui=bold,underline
endif

" }}}
" Autocmds {{{
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
	
	" Prevent auto-commenting newlines after comment
	au FileType * set fo-=c fo-=r fo-=o
	
	" Automatically close preview window
	autocmd CompleteDone * pclose

	" Auto generate ctags
	if g:is_windows 
		" NOTE(zach): Disabled
		" au BufWritePost *.c,*.cpp,*.h,*.hpp !dir /b /S *.c *.cpp *.h *.hpp > ctags
	else
		" TODO(zach):
		au BufWritePost *.c,*.cpp,*.h,*.hpp,*.m !ctags -R %
	endif

	" Jump to last known position in file
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

	" Try to prvent bell and screen flash for GUI
	autocmd GUIEnter * set vb t_vb=
	autocmd VimEnter * set vb t_vb=

  endif
endif
" }}}
" Leader shortcuts {{{
let g:mapleader=","

" Make
nmap <Leader>b :ccl<CR>:make<CR>

" Ctags + CtrlP
nnoremap <leader>. :CtrlPTag<CR>

" Jump between .c and .h files
"nnoremap <leader>s :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nmap <Leader>ss :FSHere<CR>
nmap <Leader>sh :FSLeft<CR>
nmap <Leader>sl :FSRight<CR>

" Swapping windows
"nmap <Leader>s :wincmd r<CR>

" Generate Ctags
" nnoremap <leader>t :call CtagsGen()<CR>

" Switch buffer by number
nnoremap <Leader>l :buffers<CR>:buffer<Space>

" Toggle NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Edit this file
nnoremap <Leader>ev :e<Space>$ZVIMRC<CR>

" Close current buffer without changing window layout
nnoremap <Leader>c :Bclose<CR>

if g:is_windows
	" Perforce - login
	nnoremap <Leader>pl :!p4<Space>login<CR>

	" Perforce - checkout current file
	nnoremap <Leader>pe :!p4<Space>edit<Space>%:p<CR>

	" Perforce - add current file
	nnoremap <Leader>pa :!p4<Space>add<Space>%:p<CR>
endif

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

" Turn off highlighting after found target
"nnoremap <silent><CR> :noh<CR><CR>

" Ptag current word
nmap <silent> <c-p><c-]> :ptag<Space><c-r><c-w><CR>

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <s-Tab> :bprev<CR>

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" }}}
" Backups {{{
set backup
if g:is_windows 
	set backupdir=$USERPROFILE/vimfiles/backup
	set directory=$USERPROFILE/vimfiles/tmp
else
	set backupdir=~/.vim/backup
	set directory=~/.vim/tmp
endif
set writebackup
" }}}
" Ctags {{{

" Search for "tags" in current directory, then searching up to root
set tags=./tags,tags;

" }}}
" Custom Functions {{{

" Regenerate ctags
function! CtagsGen()
	if g:is_windows 
		!ctags .
	else
		" TODO(zach):
	endif
endfunction

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
if g:is_windows 
	au GUIEnter * simalt ~x
endif
" }}}
" External configuration {{{

" If vim is ran from a directory containing a local .vim file, source that file's configuration
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif
" }}}
" Compilation {{{

if g:is_windows
	set makeprg=build.bat
	compiler msvc
else
	set makeprg=sh\ build.sh
	compiler xcodebuild
endif

" }}}
" TEST {{{

" This should call an external program
if !exists("g:external_prog")
	let g:external_prog = "/path/to/custom/external"
endif

function! TestCustomExternalProg()
	echom system(g:custom_external_prog . " " . expand('%:p'))

endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0
