" Vim compiler file
" Compiler:	Ubisoft Djinn build tool

if exists("current_compiler")
  finish
endif
let current_compiler = "djinn"

CompilerSet errorformat=[%s]\ %f(%l):\ %m
CompilerSet makeprg=build.bat


