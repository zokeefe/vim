" Vim compiler file
" Compiler:	Ubisoft Djinn build tool

if exists("current_compiler")
  finish
endif
let current_compiler = "djinn"

let s:save_cpo = &cpo
set cpo&vim

CompilerSet errorformat=[Fatal\ Error]\ %f(%l):\ %m
" CompilerSet errorformat=[%t%*\\a]\ %f(%l):\ %m
CompilerSet makeprg=build.bat

let &cpo = s:save_cpo
unlet s:save_cpo

