"{{{ https://stackoverflow.com/questions/12764999/colorizing-the-output-of-make-grep-etc-in-vim

syn match qBuilt            "Built target *" nextgroup=qTarget
syn match qTarget           ".*$"   contained

syn match qEnteringLeaving  ": \(Entering\|Leaving\) directory *" nextgroup=qdSeparator
syn match qdSeparator       "'"     nextgroup=qdName contained
syn match qdName            "[^']*" contained

syn match qbProgress        "\[ *[0-9]*%\]"
syn match qBuild            "Building .* object"
syn match qWarn             "warning\( *#[0-9]*\|\):"
syn match qError            "error\( *#[0-9]*\|\):"
syn match qRemark           "remark\( *#[0-9]*\|\):"

hi def link qTarget          Constant
hi def link qError           Error
hi def link qWarn            Error
hi def link qRemark          WarningMsg
hi def link qEnteringLeaving Keyword
hi def link qBuild           Keyword
hi def link qBuilt           Keyword
hi def link qdName           Include
hi def link qbProgress       Special

"}}}

"{{{ https://vi.stackexchange.com/questions/3250/showing-colors-in-vims-quickfix-window-from-dispatch-tasks

highlight TestOk    ctermbg=green
highlight TestError ctermbg=red

syn match TestOk    "\<Ok:"
syn match TestError "\<Err:"

"}}}
