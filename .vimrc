set nocompatible                " Vi iMproved

" Environment {{{

let g:os_win = "Windows"
let g:os_mac = "Darwin"
let g:os_lin = "Linux"
if has("win32") || has("win64")
    let g:os = g:os_win
else
    let g:os = substitute(system('uname'), '\n', '', '')
endif
if (g:os != g:os_win) && (g:os != g:os_mac) && (g:os != g:os_lin)
    throw "Unknown OS"
endif

let g:project_none  = 1
let g:project_linux = 2
let g:project = g:project_linux

"}}}
" Environment variables {{{
let s:vimfilesdir = '~/.vim/'
if g:os == g:os_win
    let s:vimfilesdir = '$USERPROFILE/vimfiles/'
endif
let $MYVIMRC = s:vimfilesdir . '.vimrc'
" }}}
" Plugins {{{

filetype off                    " Required, plugins available after

if g:os == g:os_win
    call plug#begin('$USERPROFILE/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'easymotion/vim-easymotion'

call plug#end()

filetype plugin indent on        " Required, plugins available after
" }}}
" Enable filetype plugins {{{
filetype plugin on
filetype indent on
" }}}
" AsyncRun {{{

let g:asyncrun_bell = 1             " ring bell when done
let g:asyncrun_open = 17            " this is used for all quickfix heights

" }}}
" fzf {{{ 
if g:os == g:os_win
    set rtp+=$USERPROFILE/bin
    let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_tags_command = 'ctags -R --sort=yes .'
endif

" }}}
" {{{ cscope
if has("cscope")
  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0

  " add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out  
  endif

  " show msg when any other cscope db added
  set cscopeverbose  
endif
" }}}
" Ctags {{{
" NOTE(zokeefe): Use Universal-Ctags

" Search for "tags" in current directory, then searching up to root
set tags=./tags,tags;

" }}}
" UI {{{
let g:enable_cursorline=1
set scrolloff=5
"set number                         " show line numbers
set nonumber                        " hide line numbers
set ruler                           " show cursor position in status bar
set showcmd                         " show typed command in status bar
set ignorecase                      " case insensitive searching
set smartcase                       " case sensitive when uppercase typed
set showmatch                       " show matching bracket
set wildmenu                        " completion with menu
set laststatus=2                    " use 2 lines for status bar
set lazyredraw                      " redraw only when we need to
set fillchars+=vert:\               " remove '|' character in vsplit line
set completeopt=menuone,preview     " preview window always show prototype
if g:enable_cursorline
    set cursorline                  " show cursor line
else
    set nocursorline
endif
set guioptions-=e                   " terminal-style tabs
let g:quickfix_height=g:asyncrun_open
"set list                            " displays listchars
set colorcolumn=81                  " first INVALID column
"set list listchars=tab:»\ ,trail:°  " distinguish tab / trailing ws
"set list listchars=tab:»\           " distinguish tab / trailing ws
" }}}
" Editor settings {{{
set backspace=indent,eol,start  " allow backspacing over everything in insert
                                " mode
set autoindent                  " copy indent from current line when starting
                                " new line
" Linux kernel style.
if g:project == g:project_linux
    set tabstop=8
    set shiftwidth=8
    set softtabstop=8
    set textwidth=80
    set noexpandtab
    set cindent
    set cinoptions=:0,l1,t0,g0,(0
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
    syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
    highlight default link LinuxError ErrorMsg
    syn match LinuxError / \+\ze\t/			" spaces before tab
    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/	" virtual column 81
else
    set shiftwidth=4                " spaces for autoindents
    set tabstop=4                   " number of visual spaces per tab
    set softtabstop=4               " number of spaces in tab when editing
    "set noexpandtab                " does not insert spaces instead of tabs
    set expandtab                   " inserts spaces instead of tabs
    set smarttab                    " go to next indent of next tabstop when
                                    " whitespace to left
endif
" }}}
" {{{ Sound settings
set noerrorbells                " disbale sounds
set novisualbell
set t_vb=
set tm=500
" }}}
" Folding {{{
set foldenable                  " enable folding
set foldlevelstart=0            " close all folds
set foldnestmax=10              " 10 nested folds
set foldmethod=marker           " fold based on marker
" }}}
" Searching settings {{{
set incsearch                       " show search matches during typing
set hlsearch                        " highlight searches

" To ignore search directories, use
" set wildignore+=*/path/to/ignored/directory/*

" }}}
" Font {{{
if g:os == g:os_win
    set guifont=Liberation_Mono:h10
else
    set guifont=Liberation\ Mono\ Regular:h11
endif
" }}}
" Colors {{{

if !has("gui_running") && (g:os == g:os_win)
    syntax off
else
    syntax enable
    colorscheme cmuratori

    highlight clear Todo
    " TODO(zokeefe): Why do these get cleared?
    highlight BAD ctermfg=Red guifg=Red gui=bold,underline
    highlight BAD_BG ctermbg=Red guibg=Red gui=bold,underline
    highlight IMPORTANT ctermfg=Yellow guifg=Yellow gui=bold,underline
    highlight OK ctermfg=DarkGreen guifg=DarkGreen gui=bold,underline
    highlight INTERESTING ctermfg=LightBlue guifg=LightBlue gui=bold,underline
    highlight ColorColumn ctermfg=Red ctermbg=NONE
endif

" }}}
" Autocmds {{{
if has("autocmd")
  if v:version > 701

    " Highlighting keywords
    autocmd Syntax * call matchadd('BAD', '\W\zs\(TODO\|REVIEW\|QUESTION\)')
    autocmd Syntax * call matchadd('IMPORTANT', '\W\zs\(IMPORTANT\)')
    autocmd Syntax * call matchadd('OK', '\W\zs\(NOTE\)')
    autocmd Syntax * call matchadd('INTERESTING', '\W\zs\(IDEA\|STUDY\)')

    " Highlight status line based on mode
    " Uses cmuratori colorscheme
    autocmd InsertEnter * hi statusline ctermfg=88 guifg=#912C00
    autocmd InsertLeave * hi StatusLine guifg=#161616 guibg=#7f7f7f guisp=#7f7f7f gui=NONE ctermfg=233 ctermbg=8 cterm=NONE

    " Automatically move Quickfix window to span bottom
    autocmd Filetype qf wincmd J

    " Display AsyncRun progress in status line
    augroup QuickfixStatus
        au! BufWinEnter quickfix setlocal
        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
    augroup END

    " Show cursorline in current window only
    if g:enable_cursorline
        " Warning - may cause slow rendering speed with many buffers
        augroup CursorLine
            au!
            au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
            au WinLeave * setlocal nocursorline
        augroup END
    endif

    " Prevent auto-commenting newlines after comment
    au FileType * set fo-=c fo-=r fo-=o

    " Automatically close preview window
    autocmd CompleteDone * pclose

    " Auto generate ctags
    " NOTE(zach): Disabled
    if g:os == g:os_win
        " au BufWritePost *.c,*.cpp,*.h,*.hpp !dir /b /S *.c *.cpp *.h *.hpp > ctags
    else
        " NOTE(zach): Requires Exuberant CTags
        " TODO(zach): Use RTags or Universal-Tags
        " au BufWritePost *.c,*.cpp,*.h,*.hpp,*.m !ctags -R %
    endif

    " Jump to last known position in file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " Try to prvent bell and screen flash for GUI
    autocmd GUIEnter * set vb t_vb=
    autocmd VimEnter * set vb t_vb=

    " Highlight trailing spaces
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    match BAD_BG /\s\+$/
    autocmd BufWinEnter * match BAD_BG /\s\+$/
    autocmd InsertEnter * match BAD_BG /\s\+\%#\@<!$/
    autocmd InsertLeave * match BAD_BG /\s\+$/
    autocmd BufWinLeave * call clearmatches()
  endif
endif
" }}}
" leader shortcuts {{{
let g:mapleader=","

" Make
nmap <leader>b :ZBuild<cr>

" Search
nmap <leader>s :ZSearch<space>

" Jump between .c and .h files
nmap <leader>ss :call ZHeaderToggle_('')<cr>
nmap <leader>sh :call ZHeaderToggle_('wincmd h')<cr>
nmap <leader>sl :call ZHeaderToggle_('wincmd l')<cr>

" Switch buffer by number
nnoremap <leader>l :buffers<cr>:buffer<space>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" Close current buffer without changing window layout
nnoremap <leader>c :Bclose<cr>

" Ag + AsyncRun. AsyncRun uses the global errorformat to populate
" the quickfix window. As such, add the ag-vimgrep format to the list
" before executing.
nmap <leader>ag :set errorformat+=%f:%l:%c:%m<cr> :AsyncRun<space>ag --vimgrep --hidden<space>

" }}}
" Keybindings {{{

inoremap <silent> kj <esc>
cnoremap <silent> kj <esc>
vnoremap <silent> kj <esc>
"nnoremap <silent> kj <esc>
onoremap <silent> kj <esc>
inoremap <silent> <c-c> <esc>
cnoremap <silent> <c-c> <esc>
vnoremap <silent> <c-c> <esc>
onoremap <silent> <c-c> <esc>

" Moving between windows
nmap <silent> <c-k> :wincmd k<cr>
nmap <silent> <c-j> :wincmd j<cr>
nmap <silent> <c-h> :wincmd h<cr>
nmap <silent> <c-l> :wincmd l<cr>

" Swapping  windows
nmap <silent> <c-s> :wincmd r<cr>

" Quickfix errors
nmap <silent> <c-n> :cn<cr>
nmap <silent> <c-m> :cp<cr>
nmap <silent> <c-@> :ZQuickfixToggle<cr>

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<c-u>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
  \gvy/<c-r><c-r>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<cr><cr>
  \gV:call setreg('"', old_reg, old_regtype)<cr>
vnoremap <silent> # :<c-u>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
  \gvy?<c-r><c-r>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<cr><cr>
  \gV:call setreg('"', old_reg, old_regtype)<cr>

" Fzf all files using cscope file list
  noremap <silent> <c-p> :call fzf#run({'source' : 'cat cscope.files', 'down' : '40%', 'sink' : 'e'})<cr>

" Fzf buffers
noremap <silent> <c-b> :Buffers<cr>

" }}}
" Backups {{{

" disable - use source control
set nobackup
set nowb
set noswapfile

" }}}
" Custom functions {{{

" Build
function! ZBuild_(sync)
    if a:sync
        ccl
        make
    else
        AsyncRun -program=make
    endif
endfunction

" Grep
function! ZSearch_(search, direc)
    if 0
        execute "grep" . " " a:search . " " . a:direc
    else
        set errorformat+=%f:%l:%c:%m
        execute "AsyncRun -program=grep " . a:search . " " . a:direc
    endif
endfunction

" Regenerate ctags
function! ZCtagsGen_()
    AsyncRun ctags -R --sort=yes .
endfunction

" Copy current buffer path to clipboard
function! ZCopyBufferPathToClipboard_()
    let @+ = expand('%:p')
endfunction

" Toggle quickfix
function! ZQuickfixToggle_()
    call asyncrun#quickfix_toggle(g:quickfix_height)
endfunction

" Build db
function! ZBuildDbs_()
  if g:os == g:os_win
  else
    if filereadable("~/bin/build_linux_tags_cscope.sh")
      AsyncRun sh ~/bin/build_linux_tags_cscope.sh

      " reinit cscope
      cs reset
      cs add cscope.out
    else
      throw "~/bin/build_linux_tags_cscope.sh not found"
    endif
  endif
endfunction

" Regen file list
"function! ZBuildFzfFileList_()
"    if g:os == g:os_win
"        AsyncRun dir /S /B > .fzf_filelist.txt
"    elseif g:project == g:project_linux
"        AsyncRun sh ~/Scripts/build_g3_filelist.sh
"    else
"        AsyncRun find . > .fzf_filelist.txt
"    endif
"endfunction

function! ZDeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

function! ZHeaderToggle_(where)
    let file_path = expand("%")
    let file_name = expand("%<")
    let extension = split(file_path, '\.')[-1]
    let err_msg = "There is no file "
    if extension == "cpp" || extension == "c" || extension == "cc"
        let next_file = join([file_name, ".h"], "")
        if filereadable(next_file)
            if strlen(a:where) != 0
                execute a:where
            endif
            "" Alternative :e %<.cc
            execute 'edit' next_file
        else
            echo join([err_msg, next_file], "")
        endif
    elseif extension == "h"
        let cpp = join([file_name, ".cpp"], "")
        let cc = join([file_name, ".cc"], "")
        let c = join([file_name, ".c"], "")
        if filereadable(cpp)
            if strlen(a:where) != 0
                execute a:where
            endif
            execute 'edit' cpp
        elseif filereadable(cc)
            if strlen(a:where) != 0
                execute a:where
            endif
            execute 'edit' cc
        elseif filereadable(c)
            if strlen(a:where) != 0
                execute a:where
            endif
            execute 'edit' c
        else
            echo join([err_msg, next_file], "")
        endif
    endif
endfunction

" }}}
" {{{ Custom commands

command! -nargs=0 -bang ZBuild call ZBuild_(<bang>0)
command! -nargs=+ ZSearch call ZSearch_(<f-args>)
command! -nargs=0 ZCopyBufferPathToClipboard call ZCopyBufferPathToClipboard_()
command! -nargs=0 ZQuickfixToggle call ZQuickfixToggle_()
command! -nargs=0 ZBuildDbs call ZBuildDbs_()

" }}}
" Misc. {{{

set grepprg=ag\ --vimgrep\ --hidden\ $* " use ag
set grepformat=%f:%l:%c:%m              " match ag with --vimgrep
set visualbell                          " enable vim's internal visual bell
set t_vb=                               " set vim's internal bell to do nothing
if g:enable_cursorline
    set guicursor=a:blinkon600-blinkoff400  " Slow down cursor blinking speed
endif
if has("gui_running")
    set guioptions-=L                   " remove gvim left scrollbar
    set guioptions-=R                   " remove gvim right scrollbar
    set guioptions-=l                   " remove gvim left scrollbar
    set guioptions-=r                   " remove gvim right scrollbar extra
    set guioptions-=m                   " remove gvim menu
    set guioptions-=T                   " remove gvim toolbar
endif
if has("gui_macvim")                    " set macvim specific stuff
    let macvim_skip_colorscheme=1
    set lines=999 columns=999           " start fullscreen
endif
if g:os == g:os_win
    au GUIEnter * simalt ~x
endif

" Example of multifile search and replace
" :args `ag -l 'FOO'`
" :argdo %s/FOO/BAR/g | update

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

if g:os == g:os_win
    if s:project == s:project_none
        compiler! msvc
        set makeprg=cl\ $VIM_FILEPATH
    else
        compiler! msvc
        set makeprg=build.bat
    endif
elseif g:os == g:os_mac
    if g:project == g:project_none
        compiler! clang
        set makeprg=clang\ $VIM_FILEPATH
    else
        compiler! xcodebuild
        set makeprg=sh\ build.sh
    endif
elseif g:os == g:os_lin
    compiler! gcc
    set makeprg=sh\ ~/bin/build_linux.sh
endif

" }}}
" TEST {{{
" }}}

" vim:foldmethod=marker:foldlevel=0
