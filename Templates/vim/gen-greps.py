#!/usr/bin/env python
from sys import argv
from os.path import split
from pathlib import Path
from copy import deepcopy

# keys and settings {{{

MAX_PREV = 10
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
    {str(n): f"-r '.Bp({n}).'" for n in range(1, MAX_PREV + 1)}
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

VGREP_PATTERNS = {
    "u": " /'.Expand('<cword>').'/gj ",
    "w": " /'.Expand('<cWORD>').'/gj ",
    "e": " /'.Expand('<cexpr>').'/gj ",
    "y": " /'.Vescape(@\").'/gj ",
    "g": " /'.Vescape(@*).'/gj ",
    "p": " /'.Vescape(@+).'/gj ",
    "s": " /'.Vescape(GetVisualSelection()).'/gj ",
}

GREP_PATTERNS = {
    "u": " '.Expand('<cword>').' ",
    "w": " '.Expand('<cWORD>').' ",
    "e": " '.Expand('<cexpr>').' ",
    "y": " '.Vescape(@\").' ",
    "g": " '.Vescape(@*).' ",
    "p": " '.Vescape(@+).' ",
    "s": " '.Vescape(GetVisualSelection()).' ",
}

AG_PATTERNS = deepcopy(GREP_PATTERNS)
RG_PATTERNS = deepcopy(AG_PATTERNS)

#  }}}

# generators {{{


def generate_cmds(file, name, ccmd, lcmd, gen_basic=False):
    if gen_basic:
        print(
            f"""
command -nargs=+ -complete=file {ccmd}
        \\ cgetexpr Fgrep(s:{name}_prog, <f-args>)
command -nargs=+ -complete=file {lcmd}
        \\ lgetexpr Fgrep(s:{name}_prog, <f-args>)
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


def generate_space_pre(
    file,
    desc,
    combinations,
    space="<Space>",
    end="<Home><C-Right><Right>",
    pre="",
):
    for key, path in combinations.items():
        generate_single(file, desc, space + key, f" {pre} {path} {end}")


def generate_space_post(file, desc, combinations, space="<Space>", end=""):
    for key, path in combinations.items():
        generate_single(file, desc, key + space, f"{path}{end}")


def generate_maps(file, desc, combinations, pattern, count="", end="<CR>"):
    for key, path in combinations.items():
        gen_pat = f"{pattern[1]}{path}{end}"
        generate_single(file, desc, pattern[0] + key, gen_pat, count)


#  }}}

SCRIPT_PATH = Path(split(argv[0])[0])
VIM_PATH = SCRIPT_PATH / ".." / ".." / ".vim" / "after" / "plugin"

with open(VIM_PATH / "greps.vim", "w") as f:
    with open(SCRIPT_PATH / "greps.vim", "r") as template:
        print(template.read(), file=f)
        print(file=f)

    print('" vimgrep {{{', file=f)
    generate_cmds(f, VGREP_DESC[1], "vimgrep", "lvimgrep")
    print(file=f)
    print("function s:SetupVimgrep()", file=f)
    generate_single(f, VGREP_DESC, "c", count=VGREP_COUNT)
    generate_space_pre(
        f,
        VGREP_DESC,
        VGREP_COMBINATIONS,
        end="<Home><C-Right><Right><Right>",
        pre="//gj",
    )
    generate_space_pre(
        f,
        VGREP_DESC,
        VGREP_COMBINATIONS,
        space="f",
        end="<Home><C-Right><Right><Right>",
        pre="//fgj",
    )
    generate_space_post(f, VGREP_DESC, VGREP_PATTERNS)
    for pattern in VGREP_PATTERNS.items():
        print(file=f)
        generate_maps(f, VGREP_DESC, VGREP_COMBINATIONS, pattern)
    print(file=f)
    print("endfunction", file=f)
    print(
        f'call lazy_utils#LoadOnKeys("{VGREP_DESC[0]}",'
        + 'expand("<SID>").."SetupVimgrep")',
        file=f,
    )
    print('" }}}\n', file=f)

    print('" standard grep {{{', file=f)
    generate_cmds(f, GREP_DESC[1], "Cgrep", "Lgrep", True)
    print(file=f)
    print("function s:SetupGrep()", file=f)
    generate_single(f, GREP_DESC, "c")
    generate_space_pre(f, GREP_DESC, GREP_COMBINATIONS)
    generate_space_post(f, GREP_DESC, GREP_PATTERNS)
    print(file=f)
    for pattern in GREP_PATTERNS.items():
        print(file=f)
        generate_maps(f, GREP_DESC, GREP_COMBINATIONS, pattern)
    print("endfunction", file=f)
    print(file=f)
    print(
        f"""
noremap <expr> {GREP_DESC[0]}- g:qfloc ?
\\ ':<C-u>Lfilter /^grep: /<CR>'
\\ : ':<C-u>Cfilter /^grep: /<CR>'
    """,
        file=f,
    )
    print(
        f'call lazy_utils#LoadOnKeys("{GREP_DESC[0]}",'
        + 'expand("<SID>").."SetupGrep")',
        file=f,
    )
    print('" }}}\n', file=f)

    print('" ripgrep {{{', file=f)
    generate_cmds(f, RG_DESC[1], "Crg", "Lrg", True)
    print(file=f)
    print("function s:SetupRg()", file=f)
    generate_single(f, RG_DESC, "c")
    generate_space_pre(f, RG_DESC, RG_COMBINATIONS)
    generate_space_post(f, RG_DESC, RG_PATTERNS)
    print(file=f)
    for pattern in RG_PATTERNS.items():
        print(file=f)
        generate_maps(f, RG_DESC, RG_COMBINATIONS, pattern)
    print("endfunction", file=f)
    print(file=f)
    print(
        f'call lazy_utils#LoadOnKeys("{RG_DESC[0]}",'
        + 'expand("<SID>").."SetupRg")',
        file=f,
    )
    print('" }}}\n', file=f)

    print('" silver searcher {{{', file=f)
    generate_cmds(f, AG_DESC[1], "Cag", "Lag", True)
    print(file=f)
    print("function s:SetupAg()", file=f)
    generate_single(f, AG_DESC, "c")
    generate_space_pre(f, AG_DESC, AG_COMBINATIONS)
    generate_space_post(f, AG_DESC, AG_PATTERNS)
    for pattern in AG_PATTERNS.items():
        print(file=f)
        generate_maps(f, AG_DESC, AG_COMBINATIONS, pattern)
    print("endfunction", file=f)
    print(file=f)
    print(
        f'call lazy_utils#LoadOnKeys("{AG_DESC[0]}",'
        + 'expand("<SID>").."SetupAg")',
        file=f,
    )
    print('" }}}\n', file=f)

#     print('" additional {{{', file=f)
#     print(file=f)
#     print(
#         # TODO C filtering errors
#         f"""
# noremap {GREP_DESC[0]}j :<C-u>Sgrep<Space>
# noremap {GREP_DESC[0]}J :<C-u>Sgrep!<Space>
# noremap {RG_DESC[0]}j :<C-u>Srg<Space>
# noremap {RG_DESC[0]}J :<C-u>Srg!<Space>
# noremap {AG_DESC[0]}j :<C-u>Sag<Space>
# noremap {AG_DESC[0]}J :<C-u>Sag!<Space>
#     """,
#         file=f,
#     )
#     print(file=f)
#     print('" }}}', file=f)
#     print(file=f)
