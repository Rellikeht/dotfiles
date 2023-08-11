var
  silent {.compiletime.} = false
  scrbase {.compiletime.} = false
  tic {.compiletime.} = false
  strip {.compiletime.} = false
  musl {.compiletime.} = false
  stat {.compiletime.} = false

template define(name) =
  static:
    name = true

when defined nimStrictMode:
  --experimental:strictNotNil
  --warningAsError:strictNotNil

# Emscripten (untested)
when getCommand() == "emc":
  --cc:clang
  --clang.exe:"emcc"
  --clang.linkerexe:"emcc"
  setCommand("c")

# zig cc (untested)
# TODO make this work with static compilation
# and musl when zig compiler will be ready
when getCommand() == "zc":
  --cc:clang
  --clang.exe:"zigcc"
  --clang.linkerexe:"zigcc"
  setCommand("c")

# script mode activated with
#!/usr/bin/env -S nim c -d:script
# on first line when on unix
# Works much better than nim e

when defined gscript:
  define(scrbase)

elif defined script:
  define(scrbase)
  define(tic)

elif defined cscript:
  define(scrbase)
  define(tic)
  # this is fastest in compilation but doesn't work with incremental
  --mm:boehm

else:
  --styleCheck:hint

# script base
when scrbase:
  --r
  --d:release
  --checks:on
  define(silent)

# all silent
when silent or defined silent:
  --hints:off
  --warnings:off
  --styleCheck:off
  --debuginfo:off
  --verbosity:0


# tcc
when tic or defined tic:
  when not silent and not defined silent:
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


when defined smusl:
  define(musl)
  define(stat)

# full musl experience
when musl or defined musl:
  --cc:gcc
  --gcc.exe:"musl-gcc"
  --gcc.linkerexe:"musl-gcc"
  --d:dmusl

# musl yay
when defined dmusl:
  --l:"-mmusl"

# static binary
when stat or defined stat:
  --l:"-static"

#when strip:
when strip or defined strip:
  --l:"-s"
