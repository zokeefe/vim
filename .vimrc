set nocompatible                " Vi iMproved

" Environment {{{

let s:is_windows = 0
if has("win32") || has("win64")
    let s:is_windows = 1
endif

let s:project_none  = 1
let s:project_tetra = 2
let s:project = s:project_tetra

let s:is_tabs = 0
if s:project == s:project_tetra
    let s:is_tabs = 0
endif

let s:lang_c = 1
let s:lang_cpp = 2
let s:lang_objc = 3
let s:lang = s:lang_c
if s:project == s:project_tetra
    let s:lang = s:lang_cpp
endif

"}}}
" Environment variables {{{
let s:vimfilesdir = '~/.vim/'
if s:is_windows
    let s:vimfilesdir = '$USERPROFILE/vimfiles/'
endif
let $MYVIMRC = s:vimfilesdir . '.vimrc'
" }}}
" Plugins {{{

filetype off                    " Required, plugins available after

if s:is_windows 
        call plug#begin('$USERPROFILE/vimfiles/plugged')
else
        call plug#begin('~/.vim/plugged')
endif

Plug 'scrooloose/nerdtree'
Plug 'haya14busa/incsearch.vim'
"Plug 'vim-scripts/a.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on        " Required, plugins available after

" }}}
" fzf {{{ 
if s:is_windows 
    set rtp+=$USERPROFILE/bin
    let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_tags_command = 'ctags -R --sort=yes code'
endif

" }}}
" CtrlP {{{
"if !s:is_windows
    let g:ctrlp_map = '<C-L>'
    let g:ctrlp_cmd = 'CtrlP'
    " Nearest ancestor of the current file containing either .git, .hg, .svn,
    " .bzr, or other root markers
    let g:ctrlp_max_files=0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_max_depth = 20
    let g:ctrlp_by_filename = 1
    let g:ctrlp_by_regexp = 1
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:500'
    " let g:ctrlp_use_caching = 0
"endif

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
"if s:lang == s:lang_c
"    au! BufEnter *.c let b:fswitchst = 'h'
"    au! BufEnter *.m let b:fswitchst = 'h'
"    au! BufEnter *.h let b:fswitchst = 'c,m'
"    " au! BufEnter *.h let b:fswitchst = 'c'
"else
    " au! BufEnter *.cpp let b:fswitchst = 'h,hpp'
    au! BufEnter *.cpp let b:fswitchst = 'h'
    " au! BufEnter *.hpp let b:fswitchst = 'cpp'
    au! BufEnter *.h let b:fswitchst = 'cpp'
"endif
" }}}
" AsyncRun {{{
" let g:asyncrun_exit = "!>nul"
" }}}
" Scratch {{{
let g:scratchfile = s:vimfilesdir . '.scratch'
" }}}
" Enable filetype plugins {{{
filetype plugin on
filetype indent on
" }}}
" UI {{{
"set number                        " show line numbers
set nonumber                    " hide line numbers
set ruler                        " show cursor position in status bar
set showcmd                        " show typed command in status bar
set ignorecase                    " case insensitive searching
set smartcase                    " case sensitive when uppercase typed
set showmatch                    " show matching bracket
set wildmenu                    " completion with menu
set laststatus=2                " use 2 lines for status bar
set lazyredraw                    " redraw only when we need to
set fillchars+=vert:\             " remove '|' character in vsplit line
set completeopt=menuone,preview " preview window always show prototype
"set cursorline                    " show cursor line
set guioptions-=e                               " terminal-style tabs
let g:quickfix_height= 20
if s:is_tabs == 0
    set list
    set listchars=tab:>-
endif
" }}}
" Editor settings {{{
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " copy indent from current line when starting new line
set shiftwidth=4                " spaces for autoindents
set tabstop=4                   " number of visual spaces per tab
set softtabstop=4               " number of spaces in tab when editing
set noexpandtab
set expandtab                   " inserts spaces instead of tabs
set smarttab                    " go tot next indent of next tabstop when whitespace to left

" }}}
" Folding {{{
set foldenable                  " enable folding
set foldlevelstart=0            " close all folds
set foldnestmax=10              " 10 nested folds
set foldmethod=marker           " fold based on marker
" }}}
" Searching settings {{{
set incsearch                   " show search matches during typing
set hlsearch                    " highligh searches

if s:project == s:project_tetra
    set wildignore+=*/data/*
        set wildignore+=*/data_override/*
        set wildignore+=*/data_final/*
        set wildignore+=*/data_parts/*
        set wildignore+=*/data_tmp/*
        set wildignore+=*/data_user/*
        set wildignore+=*/external/*
        set wildignore+=*/libraries/*
        set wildignore+=*/python/*
        set wildignore+=*/bin/*
        set wildignore+=*/buildmonkey/*
        set wildignore+=*/fastbuild/*
        set wildignore+=*/Output/*
        set wildignore+=*/online_backend/*
        set wildignore+=*/tmp/*
        set wildignore+=*/tools/*
        set wildignore+=*/sce_module/*
        set wildignore+=*/sce_sys/*
        set wildignore+=*/code/AIDirectorInterface/*
        "set wildignore+=*/code/AIEngine/*
        set wildignore+=*/code/Animation/*
        set wildignore+=*/code/AnimationCore/*
        set wildignore+=*/code/AnimationMotionMatching/*
        set wildignore+=*/code/AnimationOld/*
        set wildignore+=*/code/AnimMaker/*
        set wildignore+=*/code/Api/*
        set wildignore+=*/code/BoardGame/*
        set wildignore+=*/code/Browse/*
        set wildignore+=*/code/Cinema/*
        "set wildignore+=*/code/Core/*
        set wildignore+=*/code/Debug/*
        "set wildignore+=*/code/devnotes.txt/*
        set wildignore+=*/code/Disrupt/*
        set wildignore+=*/code/Disrupt.ApplicationModel/*
        set wildignore+=*/code/Disrupt.Controls/*
        set wildignore+=*/code/Disrupt.Core/*
        set wildignore+=*/code/Disrupt.IconLibrary/*
        set wildignore+=*/code/Disrupt.Interop/*
        "set wildignore+=*/code/Dunia/*
        set wildignore+=*/code/Dunia.Creator/*
        set wildignore+=*/code/Dunia.Interop/*
        set wildignore+=*/code/Editor/*
        set wildignore+=*/code/EditorAll/*
        set wildignore+=*/code/EditorCLI/*
        set wildignore+=*/code/EditorControls/*
        set wildignore+=*/code/EditorCore/*
        set wildignore+=*/code/EditorExporter/*
        set wildignore+=*/code/EditorFCX/*
        set wildignore+=*/code/EditorManagedControls/*
        set wildignore+=*/code/EditorMove/*
        "set wildignore+=*/code/Engine/*
        "set wildignore+=*/code/EngineServices/*
        set wildignore+=*/code/fbuild_FCLaunch.bff
        set wildignore+=*/code/fbuild_FCLaunch_DS.bff
        set wildignore+=*/code/fbuild_Jobs.bff
        set wildignore+=*/code/fbuild_XLast.bff
        "set wildignore+=*/code/FC/*
        set wildignore+=*/code/FCUpdater/*
        "set wildignore+=*/code/Fcx/*
        set wildignore+=*/code/FC_Editor.mdef
        set wildignore+=*/code/FC_Editor.sln
        set wildignore+=*/code/FC_Editor.VC.db*
        set wildignore+=*/code/FC_Game.mdef
        set wildignore+=*/code/FC_Game.sln
        set wildignore+=*/code/FC_Game.VC.db
        set wildignore+=*/code/FC_GraphicPlayground.sln
        set wildignore+=*/code/FC_IGE.mdef
        set wildignore+=*/code/FC_IGE.sln
        set wildignore+=*/code/FC_LiveServices.sln
        set wildignore+=*/code/FC_OnlinePlayground.mdef
        set wildignore+=*/code/FC_OnlinePlayground.sln
        set wildignore+=*/code/FC_Service.sln
        set wildignore+=*/code/FC_SharpTools.sln
        "set wildignore+=*/code/Game/*
        set wildignore+=*/code/GDFWin8/*
        set wildignore+=*/code/Generate_Babel.bat
        set wildignore+=*/code/Generate_FASTBuild_Projects.bat
        set wildignore+=*/code/Generators/*
        set wildignore+=*/code/geomparser/*
        set wildignore+=*/code/GraphicPlayground/*
        set wildignore+=*/code/GraphicsDatabase/*
        set wildignore+=*/code/GraphicsRenderer/*
        set wildignore+=*/code/GraphicsToolbox/*
        set wildignore+=*/code/GSF/*
        "set wildignore+=*/code/GSFAPIConfig.xml
        set wildignore+=*/code/HelixGamex/*
        set wildignore+=*/code/IGE.Plugins/*
        set wildignore+=*/code/IGE.WPF/*
        set wildignore+=*/code/IGE.WPF.Core/*
        set wildignore+=*/code/InGameEditor/*
        set wildignore+=*/code/Jobs.vcxproj/*
        set wildignore+=*/code/Jobs.vcxproj.filters/*
        set wildignore+=*/code/Launcher/*
        set wildignore+=*/code/nuget.config
        set wildignore+=*/code/OnlinePlayground/*
        set wildignore+=*/code/OnlineSession/*
        set wildignore+=*/code/Packman/*
        "set wildignore+=*/code/Physics/*
        set wildignore+=*/code/platforms/*
        set wildignore+=*/code/PluginServices/*
        set wildignore+=*/code/PPD/*
        set wildignore+=*/code/PPDCli/*
        set wildignore+=*/code/ppdcs/*
        set wildignore+=*/code/PPDFullEngine/*
        set wildignore+=*/code/PPDProc/*
        set wildignore+=*/code/PPDRenderer/*
        set wildignore+=*/code/PPDUtils/*
        set wildignore+=*/code/RebuildDll.bat
        set wildignore+=*/code/Scry/*
        set wildignore+=*/code/Sound/*
        "set wildignore+=*/code/ToolFramework/*
        "set wildignore+=*/code/ToolServices/*
        set wildignore+=*/code/UIEngine/*
endif
" }}}
" Font {{{

if s:is_windows
    set guifont=Liberation_Mono:h10
else
    set guifont=Liberation\ Mono\ Regular:h11
endif

" }}}
" Colors {{{

if !has("gui_running") && s:is_windows
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
    if s:is_tabs == 0
        autocmd Syntax * call matchadd('BAD_BG', '/\t/')
    endif

    " Automatically open, but don't go to, Quickfix window

        " autocmd QUickFixCmdPost [^l]* nested copen
        " autocmd QUickFixCmdPost l* nested lopen

        " augroup vimrc
        "     autocmd QuickFixCmdPost * botright copen 8
        " augroup END

    if s:project != s:project_tetra
        augroup vimrc
            autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(g:quickfix_height, 1)
        augroup END
    endif

    " Automatically move Quickfix window to span bottom
    autocmd Filetype qf wincmd J

    " Display AsyncRun progress in status line
    augroup QuickfixStatus
        au! BufWinEnter quickfix setlocal 
        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
    augroup END

    " Show cursorline in current window only
    " Disabled because of slow rendering speed
    if s:project != s:project_tetra
        augroup CursorLine
            au!
            au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
            au WinLeave * setlocal nocursorline
        augroup END
    endif

    " VSplit window on startup
    "autocmd VimEnter * vsplit
    
    " Prevent auto-commenting newlines after comment
    au FileType * set fo-=c fo-=r fo-=o
    
    " Automatically close preview window
    autocmd CompleteDone * pclose

    " Auto generate ctags
    if s:is_windows 
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

    " Recognize text files
    au BufNewFile, BufRead *.txt set filetype=text

    " Set prose mode for text files
    "au FileType text call ZooProseMode()

  endif
endif
" }}}
" LEADER shortcuts {{{
let g:mapLEADER=","

" AsyncRun
nmap <LEADER>! :AsyncRun<SPACE>

" Make
if s:project == s:project_tetra
    nmap <LEADER>b :AsyncRun build.bat<CR>
else
    nmap <LEADER>b :ccl<CR>:make<CR>
endif

" Ctags + CtrlP
nnoremap <LEADER>. :CtrlPTag<CR>

" Jump between .c and .h files
nmap <LEADER>ss :call HeaderToggle('')<CR>
nmap <LEADER>sh :call HeaderToggle('wincmd h')<CR>
nmap <LEADER>sl :call HeaderToggle('wincmd l')<CR>

" Open scratch file
nmap <LEADER>sf :e g:scratchfile<CR>

" Swapping windows
"nmap <LEADER>s :wincmd r<CR>

" Generate Ctags
" nnoremap <LEADER>t :call CtagsGen()<CR>

" Switch buffer by number
nnoremap <LEADER>l :buffers<CR>:buffer<SPACE>

" Toggle NERDTree
nnoremap <LEADER>n :NERDTreeToggle<CR>

" Edit this file
nnoremap <LEADER>ev :e<SPACE>$ZVIMRC<CR>

" Close current buffer without changing window layout
nnoremap <LEADER>c :Bclose<CR>

if s:is_windows
    " Perforce - login
    nnoremap <LEADER>pl :!p4<SPACE>login<CR>

    " Perforce - checkout current file
    nnoremap <LEADER>pe :!p4<SPACE>edit<SPACE>%:p<CR>

    " Perforce - add current file
    nnoremap <LEADER>pa :!p4<SPACE>add<SPACE>%:p<CR>

    " Perforce - mark current file for delete
    nnoremap <LEADER>pd :!p4<SPACE>delete<SPACE>%:p<CR>
endif

" Ag + AsyncRun
nmap <LEADER>ag :AsyncRun<SPACE>ag<SPACE>

if s:project == s:project_tetra
    nmap <LEADER>r :AsyncRun run_game.bat<CR>
endif

" }}}
" Keybindings {{{

" inoremap <SILENT> iu <ESC>
" cnoremap <SILENT> iu <C-c>
" vnoremap <SILENT> iu <ESC>
" nnoremap <SILENT> iu <ESC>
" onoremap <SILENT> iu <ESC>

" Moving between windows
nmap <SILENT> <C-K> :wincmd k<CR>
nmap <SILENT> <C-J> :wincmd j<CR>
nmap <SILENT> <C-H> :wincmd h<CR>
nmap <SILENT> <C-L> :wincmd l<CR>

" Swapping  windows
nmap <SILENT> <C-S> :wincmd r<CR>

" Quickfix errors
nmap <SILENT> <C-N> :cn<CR>
nmap <SILENT> <C-M> :cp<CR>
nmap <SILENT> <C-SPACE> :call QuickfixToggle()<CR>

" Workaround for console vim on OS X Terminal.app
noremap <NUL> :ccl<CR>

" Turn off highlighting after found target
"nnoremap <SILENT><CR> :noh<CR><CR>

" Ptag current word
nmap <SILENT> <C-P><C-]> :ptag<SPACE><C-R><C-W><CR>

" Buffer navigation
nnoremap <Tab> :e #<CR>

" Exit terminal
tnoremap <ESC> <C-\><C-N>

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <SILENT> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <SILENT> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Fzf all files
noremap <SILENT> <C-P> :call fzf#run({'source' : 'type filelist.txt', 'down' : '40%', 'options' : '--preview "type {}"', 'sink' : 'e'})<CR>

" Fzf buffers
noremap <SILENT> <C-B> :Buffers<CR>

" }}}
" Backups {{{
set backup
if s:is_windows 
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
function! ZooCtagsGen()
    if s:project == s:project_tetra
        AsyncRun ctags -R --sort=yes code
    endif
endfunction

" Copy current buffer path to clipboard
function! ZooCopyBufferPathToClipboard()
    let @+ = expand('%:p')
endfunction

" Convert all backwards slashes to forward slashes
function! ZooBackToForwardSlashes()
    s/\\/\//g
endfunction

" Convert all forward slashes to backward slashes
function! ZooForwardToBackSlashes()
    s/\//\\/g
endfunction

" Toggle quickfix
function! QuickfixToggle()
    call asyncrun#quickfix_toggle(g:quickfix_height)
endfunction

" Corrects and adds missing CRCs
function! TetraStringIdTool()
    if(s:project == s:project_tetra)
       AsyncRun bin\tools\StringIDTool\StringIDTool.exe -s+ %
    endif
endfunction

" Runs codegen
function! TetraBuildCodegen()
    if(s:project == s:project_tetra)
        AsyncRun build_codegen.bat
    endif
endfunction

" Regenerates project
function! TetraRegenProjects()
    if(s:project == s:project_tetra)
        AsyncRun code\Generate_FASTBuild_Projects.bat
    endif
endfunction

" Regen file list
function! TetraBuildFileList()
if(s:project == s:project_tetra)
        AsyncRun dir /S /B code > filelist.txt
    endif
endfunction

" Resets tab-based editor
function! ZooSetTabEditorLocal()
    setlocal tabstop=4
    setlocal noexpandtab
    setlocal nosmarttab
    setlocal softtabstop=0
endfunction

function! ZooDeleteInactiveBufs()
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
            SILENT exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

function! ZooProseMode()
    " a - autoformat paragraph when changed
    " t - auto-wrap using textwidth
    " w - defines paragraphs seperated by blank line
    " n - recognize numbered lists
    "setlocal formatoptions+=atn

    "" Disable the status line
    "setlocal laststatus=0

    "" Set Canadian spelling
    "setlocal spell spelllang=en_ca

    "setlocal nonumber

    "" Longer value will be broken
    "setlocal textwidth=80

    "" Also wrap at end of window border
    "setlocal wrapmargin=0

    "" Disable autoindent
    "setlocal noautoindent
    "setlocal nocindent
    "setlocal nosmartindent
    "setlocal indentexpr=

    "" Easy navigation
    "nmap <SILENT> <k> gk
    "nmap <SILENT> <j> gj

    "nmap <SILENT> <c-s> z=
    "nmap <SILENT> <s> z= 
endfunction

function! HeaderToggle(where)
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
" Misc. {{{

set visualbell                    " enable vim's internal visual bell
set t_vb=                        " set vim's internal bell to do nothing
set guicursor=a:blinkon600-blinkoff400  " Slow down cursor blinking speed
if has("gui_running")
    set guioptions-=L            " remove gvim left scrollbar
    set guioptions-=R            " remove gvim right scrollbar
    set guioptions-=l            " remove gvim left scrollbar extra
    set guioptions-=r            " remove gvim right scrollbar extra
    set guioptions-=m            " remove gvim menu 
    set guioptions-=T            " remove gvim toolbar 
endif
if has("gui_macvim")            " set macvim specific stuff
    let macvim_skip_colorscheme=1
    set lines=999 columns=999    " start fullscreen
endif
if s:is_windows 
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

if s:is_windows
    if s:project == s:project_tetra
        compiler! msvc
    else
        compiler! msvc
        set makeprg=build.bat
    endif
else
    compiler! xcodebuild
    set makeprg=sh\ build.sh
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
