.de END
..
.ig END
This is for comments
.END

.nr PO 2c
.nr LL 17c
.nr HM 1.5c
.nr FM 1.5c
.fam H

.ig END
Left margin (page offset)
Line length
Top margin
Bottom margin
Font family
.END

.ig END
Inline equations
.END

.EQ
delim $$
.EN

.ig END
bullet list
.END

.de LB
.IP •
..

.ig END
List with numbers
And setting count
.END

.de LNS
.nr step 0 1
..

.de LN
.IP \n+[step]
..

.de LM
.IP -
..

.ig END
roots

.EQ
define root % sqrt special Rt %
.EN
.de Rt
.  ds 0s \
\Z'\h'0.3n'\\*(0s'\
\h'-0.1n-\\n(0hu'\
\v'\\n(0du-1n'
..

.END
