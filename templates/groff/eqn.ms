.so helpers.ms

.de END
..
.ig END
This is for comments
.END

.ig END
Numbered equations
.nr myeqn 0 1
.\" ...stuff...
.EQ C \n+[myeqn]
e sup {i pi} + 1 = 0
.EN
.END

.ig END
https://douglasrumbaugh.com/post/groff-eqn/
.END

.ig END
Inline equations
.END

.EQ
delim $$
.EN

.EQ
sum from i=0 to k 1 over {n sup 2}
.EN

.ig END
spaces
.END

.EQ
x^+^y ~~~~ = ^^^^ 0
.EN

.ig END
sadge generally, but somehow works:
.END

.EQ
~ sup 1000 sqrt x
.EN

.EQ
lim from {x -> 0 sup +} sin(x) over x = 1
.EN

.ig END
There is also lpile and rpile
.END

.EQ
pile {{x} above {y} above {z}}
.EN

.EQ
pile {{x} {y} {z}}
.EN

.ig END
left { makes { stretch
.END

.EQ
f(x) = left { lpile {
    { x sup 2 ,~~~x >= 0 }  above
    { 0, ~~~~ x < 0 } 
}
.EN

.ig END
MATRICES
.END

.EQ
left [
matrix {

    col { 1 above 0 }
    col { 0 above 1 }

}
right ]
.EN


.EQ
left [
matrix {

    col { {x sup 2} above {y sup 2} }
    col { {z sup 2} above {w sup 2} }
    col { 0 above 1 }

}
right ]
.EN

.ig END
Aligining equations
And it all simply fucking works
.END

.EQ
x sup 0 + x sup 1 + x sup 2 + ... + x sup n mark = 1
.EN

.EQ
y lineup = x sup 0 + x sup 1 + x sup 2 + ... + x sup n
.EN

.EQ
x sup 2 = -1
~~~~
\[rA]
~~~~
x = +- i
.EN

.ig END
arrows ??
.END

.EQ
->
~~
<-

~~
=>
~~
< =

~~
⇒
~~
⇐

~~
\[<>]

~~
\[rA]
~~
\[lA]

~~
\[<-]
~~
\[->]

.EN

.ig END
TODO more symbols
.END

.EQ
define in %^\[mo]^%
define notin %^\[nm]^%
define rA %^\[rA]^%
define lA %^\[lA]^%
define dA %^\[dA]^%
define uA %^\[uA]^%

define c+ %^\[c+]^%
define c* %^\[c*]^%
define c. %^⊙^%

define Nn %^ℕ^%
define Zn %^ℤ^%
define Qn %^ℚ^%
define Rn %^ℝ^%
define Cn %^ℂ^%

define comment ' This is ugly, but may work '
define Nn ' roman { N back 56.5 N } '
define Zn ' roman { Z back 45 Z } '
define Qn ' roman { Q back 58 Q } '
define Rn ' roman { R back 53 R } '
define Cn ' roman { C back 52 C } '

Nn ~ Zn ~ Qn ~ Rn ~ Cn

.EN

.EQ

x in Rn , y in Qn rA x c. y = y c* x

.EN

.bp

.ig END
those try to be better roots:
.END

.EQ
define exp % "" sup fwd 50 %
define cube % "" sup fwd 50 3 sqrt %
define root % { "" sup fwd 50 $1 sqrt $2 } %
.EN

.EQ
pile {
    { exp 3 sqrt 11 } above

    { cube 11 } above

    { root(1000,11) }
}
.EN
