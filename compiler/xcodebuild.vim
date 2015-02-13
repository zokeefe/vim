" Vim compiler file
" Compiler: xcodebuild

if exists("current_compiler")
	finish
endif
let current_compiler = "xcodebuild"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo&vim

CompilerSet makeprg=sh\ build.sh

CompilerSet errorformat=
	\%f:%l:%c:{%*[^}]}:\ error:\ %m,
	\%f:%l:%c:{%*[^}]}:\ fatal\ error:\ %m,
	\%f:%l:%c:{%*[^}]}:\ warning:\ %m,
	\%f:%l:%c:\ error:\ %m,
	\%f:%l:%c:\ fatal\ error:\ %m,
	\%f:%l:%c:\ warning:\ %m,
	\%f:%l:\ Error:\ %m,
	\%f:%l:\ error:\ %m,
	\%f:%l:\ fatal\ error:\ %m,
	\%f:%l:\ warning:\ %m 

let &cpo = s:save_cpo
unlet s:save_cpo
