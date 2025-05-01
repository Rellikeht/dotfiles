#!/usr/bin/env python
from sys import argv
from os.path import split
from pathlib import Path
from copy import deepcopy

# keys and settings {{{

MAX_PREV = 8
QFVAR = "g:qfloc"
CU = ":<C-u>"

VGREP_DESC = ("<Space>v", "vimgrep")
VGREP_COUNT = "'.Vgcount().'"
GREP_DESC = ("<Space>f", "grep")
RG_DESC = ("<Leader>r", "rg")
AG_DESC = ("<Leader>a", "ag")

#  }}}

# combinations {{{

VGREP_COMBINATIONS = {
    "c": "",
    "f": "%",
    "F": "#",
    "a": "##",
    "l": "* .*",
    "L": "*",
    "r": "{.[^.]*,*}/**/{.*,*} * .*",  # yeah, vim globs...
    "R": "**",
}
# probably won't be useful anyway
# VGREP_COMBINATIONS.update({str(n): f"'.Bp({n}).'" for n in range(1, 10)})

GEN_PATHS = {
    "r": ".",
    "g": "'.GitRoot().'",
    "G": "'.GitRoot(GitRoot().'/..').'",
    "m": "'.HgRoot().'",
    "M": "'.HgRoot(HgRoot().'/..').'",
    "e": "'.EnvrcRoot().'",
    "E": "'.EnvrcRoot(EnvrcRoot().'/..').'",
    "<C-e>": "'.EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..').'",
    "b": "'.g:starting_path.'",
}

GREP_COMBINATIONS = {
    "f": "%",
    "F": "#",
    "a": "##",
    "l": "* .*",
    "L": "*",
}
AG_COMBINATIONS = deepcopy(GREP_COMBINATIONS)

GREP_COMBINATIONS.update({k: "-r " + v for k, v in GEN_PATHS.items()})
GREP_COMBINATIONS.update(
    {str(n): f"-r '.Bp({n}).'" for n in range(1, MAX_PREV)}
)
AG_COMBINATIONS.update({k: "--hidden " + v for k, v in GEN_PATHS.items()})
AG_COMBINATIONS.update(
    {str(n): f"--hidden '.Bp({n}).'" for n in range(1, MAX_PREV)}
)

AG_COMBINATIONS.update(
    {
        "l": "--depth 0 * .*",
        "L": "--depth 0 *",
        "r": "--hidden .",
        "R": ".",
        #
    }
)

RG_COMBINATIONS = deepcopy(AG_COMBINATIONS)
RG_COMBINATIONS.update(
    {
        "l": "--max-depth 0 * .*",
        "L": "--max-depth 0 *",
        #
    }
)

#  }}}

# patterns {{{

VGREP_PATTERNS = (
    ("<Space>", " //gj ", " <Home><C-Right><Right><Right>"),
    ("f", " //gjf ", " <Home><C-Right><Right><Right>"),
    ("u", " /'.Expand('<cword>').'/gj ", "<CR>"),
    ("w", " /'.Expand('<cWORD>').'/gj ", "<CR>"),
    ("e", " /'.Expand('<cexpr>').'/gj ", "<CR>"),
    ("y", " /'.Vescape(@\").'/gj ", "<CR>"),
    ("g", " /'.Vescape(@*).'/gj ", "<CR>"),
    ("p", " /'.Vescape(@+).'/gj ", "<CR>"),
    ("s", " /'.Vescape(GetVisualSelection()).'/gj ", "<CR>"),
)

GREP_PATTERNS = (
    ("<Space>", "  ", "<Home><C-Right><Right>"),
    ("u", " '.Expand('<cword>').' ", "<CR>"),
    ("w", " '.Expand('<cWORD>').' ", "<CR>"),
    ("e", " '.Expand('<cexpr>').' ", "<CR>"),
    ("y", " '.Vescape(@\").' ", "<CR>"),
    ("g", " '.Vescape(@*).' ", "<CR>"),
    ("p", " '.Vescape(@+).' ", "<CR>"),
    ("s", " '.Vescape(GetVisualSelection()).' ", "<CR>"),
)

AG_PATTERNS = deepcopy(GREP_PATTERNS)
RG_PATTERNS = deepcopy(AG_PATTERNS)

#  }}}

# generators {{{


def generate_cmds(file, name, ccmd, lcmd, gen_basic=False):
    if gen_basic:
        print(
            f"""
command -nargs=+ -complete=file {ccmd}
        \\ cgetexpr <SID>Fgrep(s:{name}_prog, <f-args>)
command -nargs=+ -complete=file {lcmd}
        \\ lgetexpr <SID>Fgrep(s:{name}_prog, <f-args>)
            """,
            file=file,
        )

    print(
        f"""
command -nargs=+ -complete=file S{name}
      \\ if g:qfloc
      \\ | exe '{lcmd} '.<q-args>
      \\ | else
      \\ | exe '{ccmd} '.<q-args>
      \\ | endif

command -nargs=+ -complete=file W{name}
      \\ exe 'S{name} '.<q-args>
      \\ | call QFcmd('open')
        """,
        file=file,
    )


def generate_single(file, desc, key, end=" ", count=""):
    print(
        f"nnoremap <expr> {desc[0]}{key} '{CU}{count}S{desc[1]}{end}'",
        file=file,
    )


def generate_maps(file, desc, combinations, pattern, count=""):
    for key, path in combinations.items():
        gen_pat = f"{pattern[1]}{path}{pattern[2]}"
        generate_single(file, desc, pattern[0] + key, gen_pat, count)


#  }}}

SCRIPT_PATH = Path(split(argv[0])[0])
VIM_PATH = SCRIPT_PATH / ".." / ".." / ".vim"

with open(VIM_PATH / "greps.vim", "w") as f:
    with open(SCRIPT_PATH / "greps.vim", "r") as template:
        print(template.read(), file=f)
        print(file=f)

    print('" vimgrep {{{', file=f)
    print(file=f)
    generate_cmds(f, "vimgrep", "vimgrep", "lvimgrep")
    print(file=f)
    generate_single(f, VGREP_DESC, "c", count=VGREP_COUNT)
    print(file=f)
    for pattern in VGREP_PATTERNS:
        generate_maps(f, VGREP_DESC, VGREP_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    print('" standard grep {{{', file=f)
    print(file=f)
    generate_cmds(f, "grep", "Grep", "Lgrep", True)
    print(file=f)
    generate_single(f, GREP_DESC, "c")
    print(file=f)
    for pattern in GREP_PATTERNS:
        generate_maps(f, GREP_DESC, GREP_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    print('" ripgrep {{{', file=f)
    print(file=f)
    generate_cmds(f, "rg", "Rg", "Lrg", True)
    print(file=f)
    generate_single(f, RG_DESC, "c")
    print(file=f)
    for pattern in RG_PATTERNS:
        generate_maps(f, RG_DESC, RG_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    print('" silver searcher {{{', file=f)
    print(file=f)
    generate_cmds(f, "ag", "Ag", "Lag", True)
    print(file=f)
    generate_single(f, AG_DESC, "c")
    print(file=f)
    for pattern in AG_PATTERNS:
        generate_maps(f, AG_DESC, AG_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    print('" additional {{{', file=f)
    print(file=f)
    print(
        # TODO C filtering errors
        f"""
noremap <expr> {GREP_DESC[0]}- g:qfloc ?
\\ ':<C-u>Lfilter /^grep: /<CR>'
\\ : ':<C-u>Cfilter /^grep: /<CR>'

noremap {GREP_DESC[0]}j :<C-u>Sgrep<Space>
noremap {GREP_DESC[0]}J :<C-u>Sgrep!<Space>
noremap {RG_DESC[0]}j :<C-u>Srg<Space>
noremap {RG_DESC[0]}J :<C-u>Srg!<Space>
noremap {AG_DESC[0]}j :<C-u>Sag<Space>
noremap {AG_DESC[0]}J :<C-u>Sag!<Space>
    """,
        file=f,
    )
    print(file=f)
    print('" }}}', file=f)
    print(file=f)
