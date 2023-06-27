import strscans

template define(name) =
  const name {.booldefine.} = true

#when defined incc:
#  --incremental:on

# Don't know if this is needed
when defined nimStrictMode:
  --warningAsError:strictNotNil
  discard

# TODO orc by default
#when not defined mm:
#  --mm:orc
#echo mm

# script base
when defined scrbase:
  --r
  --d:release
  --checks:on
  define(silent)

# all silent
when defined silent:
  --hints:off
  --warnings:off
  --styleCheck:off
  --debuginfo:off
  --verbosity:0

# tcc
when defined tic:
  when not defined silent:
    echo "tcc yay"
  --cc:tcc
  --tlsEmulation:on

when defined release:
  --checks:off
  --debuginfo:off

when defined danger:
  --styleCheck:off
  define(silent)

# Additional debug options
when defined debug:
  --debuginfo:on
  --checks:on
  --lineTrace:on
  --stacktrace:on
  --verbosity:3

# full musl experience
when defined musl:
  --cc:gcc
  --gcc.exe:"musl-gcc"
  --gcc.linkerexe:"musl-gcc"
  --d:dmusl

# musl yay
when defined dmusl:
  --l:"-mmusl"

# static binary
when defined stat:
  --l:"-static"


proc strip(binFile, flags: string) =
  if findExe("strip") != "":
    let command = "strip " & flags & " " & binFile
    when not defined silent:
      echo "Running '" & command & "'"
    exec command

proc strip(binFile: string) {.inline.} = strip(binFile, "--strip-unneeded")
proc stripTotal(binFile: string) {.inline.} = strip(binFile, "-s")

# TODO upx
#  if findExe("upx") != "":
#    when not defined silent:
#      echo "Running 'upx --best' .."
#    exec "upx --best " & binFile

proc getBin(): string =
  for i in 2..paramCount():
    let s = paramStr(i)
    if len(s) > 4:
      if s[^4..^1] == ".nim":
        return s[0..^5]

# TODO running after compilation
#when defined strip: strip getBin()
#elif defined tstrip:
#  --d:strip
#  stripTotal getBin()
