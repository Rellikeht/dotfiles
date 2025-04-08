dnl helpers {{{
changequote([,])dnl
define([_JOIN2], [$1$2])dnl
define([JOIN], [$1$2$3$4$5$6$7$8$9])dnl
define([ID], [$1])dnl
dnl }}}

dnl operations on given arguments {{{
define([APPLY],
[ifelse([$#], [1], [],
    [ifelse([$#], [2], [$1($2)], [$1($2)][APPLY([$1], shift(shift($@)))])]dnl
)]dnl
)dnl
define([REDUCE],
[ifelse([$#], [2], [$2],
    [ifelse([$#], 3, [$1($2,$3)],
        [REDUCE([$1], [$1($2,$3)], shift(shift(shift($@))))]dnl
    )]dnl
)]dnl
)dnl
define([LJOIN], [REDUCE([_JOIN2], $@)])dnl
dnl }}}

dnl stack operations {{{
define([PUSHALL], [ifelse([$#], [2], [pushdef([$1], [$2])],
    [JOIN([pushdef([$1], [$2])], [PUSHALL([$1], shift(shift($@)))])]dnl
)])dnl
dnl
define([STACK_COPY], [ifdef([$1], [JOIN(
[pushdef([TMP], $1)],dnl
[popdef([$1])],dnl
[STACK_COPY([$1], [$2])],dnl
[pushdef([$2], TMP)],dnl
[pushdef([$1], TMP)],dnl
[popdef([TMP])]dnl
)],[])])dnl
dnl
define([STACK_APPLY], [ifdef([$1], [JOIN(
[$2($1)],dnl
[popdef([$1])],dnl
[STACK_APPLY([$1], [$2])])],dnl
[])])dnl
dnl
define([POPALL], [STACK_APPLY([$1], [ID])])dnl
dnl }}}

dnl from manual {{{
define([_arg1], [$1])dnl
define([FOREACH], [pushdef([$1])_foreach($@)popdef([$1])])dnl
define([_foreach], [ifelse([$2], [()], [], [define([$1], _arg1$2)$3[]$0([$1], (shift$2), [$3])])])dnl
define([FOREACHQ], [pushdef([$1])_foreachq($@)popdef([$1])])dnl
define([_foreachq], [ifelse(quote($2), [], [], [define([$1], [_arg1($2)])$3[]$0([$1], [shift($2)], [$3])])])dnl
dnl }}}

dnl tests and examples {{{
dnl define([K1], [ifelse([$#], [1], [$1], [$1 + K1(shift($@))])])dnl
dnl define([_ADD], [$1 + $2])dnl
dnl define([K1], [REDUCE([_ADD], $@)])dnl
dnl K1(1)
dnl K1(1, 2)
dnl K1(1, 2, 3)
dnl K1(1, 2, 3, 4, 5)

dnl define([PAR], [($1)])dnl
dnl APPLY([PAR], 1, 2, 3, 4)
dnl PUSHALL([TEST1], 0, 1, 2, 3, 4, 5)dnl
dnl STACK_COPY([TEST1], [TEST2])dnl
dnl POPALL([TEST2])
dnl STACK_APPLY([TEST1], [PAR])
dnl }}}
