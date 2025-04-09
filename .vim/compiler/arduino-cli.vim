if exists("current_compiler")
  finish
endif
let current_compiler = "arduino-cli"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=arduino-cli\ compile\ -j\ 0\ -log
CompilerSet errorformat=%f:%l:%c:\ error:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
