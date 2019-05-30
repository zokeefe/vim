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

let g:has_perforce = 0

let g:project_none  = 1
let g:project_tetra = 2
let g:project_google = 3
let g:project = g:project_google

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
Plug 'majutsushi/tagbar'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/async.vim' " needed by vim-lsp

if g:project != g:project_google
  Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
endif

call plug#end()

filetype plugin indent on        " Required, plugins available after
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
" CtrlP {{{
    " Using fzf instead
    "let g:ctrlp_map = '<c-l>'
    "let g:ctrlp_cmd = 'CtrlP'
    "" Nearest ancestor of the current file containing either .git, .hg, .svn,
    "" .bzr, or other root markers
    "let g:ctrlp_max_files=0
    "let g:ctrlp_working_path_mode = 0
    "let g:ctrlp_max_depth = 20
    "let g:ctrlp_by_filename = 1
    "let g:ctrlp_by_regexp = 1
    "let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:500'
    "" let g:ctrlp_use_caching = 0

" }}}
" Scratch {{{
let g:scratchfile = s:vimfilesdir . '.scratch'
" }}}
" Enable filetype plugins {{{
filetype plugin on
filetype indent on
" }}}
" UI {{{
let g:enable_cursorline=0
"set number                         " show line numbers
set nonumber                        " hide line numbers
set ruler                           " show cursor position in status bar
set showcmd                         " show typed command in status bar
set ignorecase                      " case insensitive searching
set smartcase                       " case sensitive when uppercase typed
set showmatch                       " show matching bracket
set wildmenu                        " completion with menu
set laststatus=2                    " use 2 lines for status bar
"set lazyredraw                      " redraw only when we need to
set fillchars+=vert:\               " remove '|' character in vsplit line
set completeopt=menuone,preview     " preview window always show prototype
if g:enable_cursorline
    set cursorline                  " show cursor line
else
    set nocursorline
endif
set guioptions-=e                   " terminal-style tabs
let g:quickfix_height=g:asyncrun_open
set list                            " displays listchars
set colorcolumn=81                  " first INVALID column
set list listchars=tab:»\ ,trail:°  " distinguish tab / trailing ws
" }}}
" Editor settings {{{
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " copy indent from current line when starting new line
set shiftwidth=4                " spaces for autoindents
set tabstop=4                   " number of visual spaces per tab
set softtabstop=4               " number of spaces in tab when editing
"set noexpandtab                " does not insert spaces instead of tabs
set expandtab                   " inserts spaces instead of tabs
set smarttab                    " go to next indent of next tabstop when whitespace to left
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
    autocmd Syntax * call matchadd('BAD', '\W\zs\(TODO\)')
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

    " Recognize text files
    au BufNewFile, BufRead *.txt set filetype=text

    " Set prose mode for text files
    "au FileType text call ZProseMode()

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

" Ctags + CtrlP
nnoremap <leader>. :CtrlPTag<cr>

" Jump between .c and .h files
nmap <leader>ss :call ZHeaderToggle_('')<cr>
nmap <leader>sh :call ZHeaderToggle_('wincmd h')<cr>
nmap <leader>sl :call ZHeaderToggle_('wincmd l')<cr>

" Generate Ctags
nnoremap <leader>t :call ZCtagsGen()<cr>

" Switch buffer by number
nnoremap <leader>l :buffers<cr>:buffer<space>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" Toggle Tagbar
nnoremap <leader>t :TagbarToggle<cr>

" Close current buffer without changing window layout
nnoremap <leader>c :Bclose<cr>

if g:has_perforce
    " Perforce - login
    nnoremap <leader>pl :!p4<space>login<cr>

    " Perforce - checkout current file
    nnoremap <leader>pe :!p4<space>edit<space>%:p<cr>

    " Perforce - add current file
    nnoremap <leader>pa :!p4<space>add<space>%:p<cr>

    " Perforce - mark current file for delete
    nnoremap <leader>pd :!p4<space>delete<space>%:p<cr>
endif

" Ag + AsyncRun. AsyncRun uses the global errorformat to populate
" the quickfix window. As such, add the ag-vimgrep format to the list
" before executing.
nmap <leader>ag :set errorformat+=%f:%l:%c:%m<cr> :AsyncRun<space>ag --vimgrep --hidden<space>

" }}}
" Keybindings {{{

" Attempt to not use <esc>
" inoremap <silent> iu <esc>
" cnoremap <silent> iu <C-c>
" vnoremap <silent> iu <esc>
" nnoremap <silent> iu <esc>
" onoremap <silent> iu <esc>

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

" Workaround for console vim on OS X Terminal.app
"noremap <NUL> :ccl<cr>

" Ptag current word
nmap <silent> <c-p><c-]> :ptag<space><c-r><c-w><cr>

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

" Fzf all files
noremap <silent> <c-p> :call fzf#run({'source' : 'type .fzf_filelist.txt', 'down' : '40%', 'options' : '--preview "type {}"', 'sink' : 'e'})<cr>

" Fzf buffers
noremap <silent> <c-b> :Buffers<cr>

" }}}
" Backups {{{
set backup
if g:os == g:os_win
    set backupdir=$USERPROFILE/vimfiles/backup
    set directory=$USERPROFILE/vimfiles/tmp
else
    set backupdir=~/.vim/backup
    set directory=~/.vim/tmp
endif
set writebackup
" }}}
" Ctags {{{
" NOTE(zokeefe): Use Universal-Ctags

" Search for "tags" in current directory, then searching up to root
set tags=./tags,tags;

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

" Open scratch file
function! ZOpenScratchFile_()
    :e g:scratchfile<cr>
endfunction

" Copy current buffer path to clipboard
function! ZCopyBufferPathToClipboard_()
    let @+ = expand('%:p')
endfunction

" Convert all backwards slashes to forward slashes
function! ZBackToForwardSlashes_()
    s/\\/\//g
endfunction

" Convert all forward slashes to backward slashes
function! ZForwardToBackSlashes_()
    s/\//\\/g
endfunction

" Toggle quickfix
function! ZQuickfixToggle_()
    call asyncrun#quickfix_toggle(g:quickfix_height)
endfunction

" Regen file list
function! ZBuildFzfFileList_()
    if g:os == g:os_win
        AsyncRun dir /S /B > .fzf_filelist.txt
    else
        AsyncRun ls -1 -R > .fzf_filelist.txt
    endif
endfunction

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

function! ZProseMode()
    " a - autoformat paragraph when changed
    " t - auto-wrap using textwidth
    " w - defines paragraphs seperated by blank line
    " n - recognize numbered lists
    setlocal formatoptions+=atn

    " Disable the status line
    setlocal laststatus=0

    " Set Canadian spelling
    setlocal spell spelllang=en_ca

    setlocal nonumber

    " Longer value will be broken
    setlocal textwidth=80

    " Also wrap at end of window border
    setlocal wrapmargin=0
    setlocal wrap
    setlocal linebreak

    " Disable autoindent
    setlocal noexpandtab
    setlocal noautoindent
    setlocal nocindent
    setlocal nosmartindent
    setlocal indentexpr=

    " Easy navigation
    nmap <silent> <k> gk
    nmap <silent> <j> gj

    nmap <silent> <c-s> z=
    nmap <silent> <s> z=
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
command! -nargs=0 ZCtagsGen call ZCtagsGen_()
command! -nargs=0 ZOpenScratchFile call ZOpenScratchFile_()
command! -nargs=0 ZCopyBufferPathToClipboard call ZCopyBufferPathToClipboard_()
command! -nargs=0 ZBackToForwardSlashes call ZBackToForwardSlashes_()
command! -nargs=0 ZForwardToBackSlashes call ZForwardToBackSlashes_()
command! -nargs=0 ZQuickfixToggle call ZQuickfixToggle_()
command! -nargs=0 ZBuildFzfFileList call ZBuildFzfFileList_()

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
endif

" }}}
" TEST {{{
" }}}

if g:project != g:project_google
  highlight LspError ctermfg=Blue
  if executable('cquery')
     au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': './.cquerycache' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
  endif
endif

" vim:foldmethod=marker:foldlevel=0
