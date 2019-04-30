if exists("clang")
  finish
endif
let current_compiler = "clang"

let s:cpo_save = &cpo
set cpo-=C

"setlocal errorformat=%f:%l:%c:\ %m
CompilerSet errorformat=%f:%l:%c:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

"vim: ft=vim

