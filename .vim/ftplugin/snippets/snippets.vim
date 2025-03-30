" Vim filetype plugin for SnipMate snippets (.snippets and .snippet files)

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl et< sts< cms< fdm< fde<"

" Use hard tabs
setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4

setlocal foldmethod=expr foldexpr=getline(v:lnum)!~'^\\t\\\\|^$'?'>1':1

setlocal commentstring=#\ %s
setlocal nospell
