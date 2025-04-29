#!/usr/bin/env python
from sys import argv
from os.path import split
from pathlib import Path

QFVAR = "g:qfloc"
CU = ":<C-u>"

VGREP_DESC = ("<Space>v", "lvimgrep", "vimgrep")
VGREP_COUNT = "'.Vgcount().'"
GREP_DESC = ("<Space>f", "Lgrep", "Grep")
# EGREP_DESC = ("<Leader>s", "Legrep", "Egrep")

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

GREP_COMBINATIONS = {
    "f": "%",
    "F": "#",
    "a": "##",
    "l": "* .*",
    "L": "*",
    "r": "-r .",
}

# EGREP_COMBINATIONS = GREP_COMBINATIONS
# EGREP_COMBINATIONS.update(
#     {
#         #
#     }
# )

VGREP_PATTERNS = (
    ("<Space>", " //gj ", " <Home><C-Right><Right><Right>"),
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
# EGREP_PATTERNS = GREP_PATTERNS


def generate_single(file, desc, key, end=" ", count=""):
    print(
        f"nnoremap <expr> {desc[0]}{key} {QFVAR} ? "
        + f"'{CU}{count}{desc[1]}{end}' : '{CU}{count}{desc[2]}{end}'",
        file=file,
    )


def generate_maps(file, desc, combinations, pattern, count=""):
    for key, path in combinations.items():
        gen_pat = f"{pattern[1]}{path}{pattern[2]}"
        generate_single(file, desc, pattern[0] + key, gen_pat, count)


SCRIPT_PATH = Path(split(argv[0])[0])
VIM_PATH = SCRIPT_PATH / ".." / ".." / ".vim"

with open(VIM_PATH / "greps.vim", "w") as f:
    with open(SCRIPT_PATH / "greps.vim", "r") as template:
        print(template.read(), file=f)
        print(file=f)

    print('" vimgrep {{{', file=f)
    generate_single(f, VGREP_DESC, "c", count=VGREP_COUNT)
    print(file=f)
    for pattern in VGREP_PATTERNS:
        generate_maps(f, VGREP_DESC, VGREP_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    print('" standard grep {{{', file=f)
    generate_single(f, GREP_DESC, "c")
    print(file=f)
    for pattern in GREP_PATTERNS:
        generate_maps(f, GREP_DESC, GREP_COMBINATIONS, pattern)
        print(file=f)
    print('" }}}', file=f)
    print(file=f)

    # print('" grep replacements {{{', file=f)
    # generate_single(f, EGREP_DESC, "c")
    # print(file=f)
    # for pattern in EGREP_PATTERNS:
    #     generate_maps(f, EGREP_DESC, EGREP_COMBINATIONS, pattern)
    #     print(file=f)
    # print('" }}}', file=f)
    # print(file=f)

    print('" additional {{{', file=f)
    print(file=f)
    # print(
    #     # TODO C filtering errors
    #     f"""
    # noremap <expr> {GREP_DESC[0]}- g:qfloc ?
    # \\ ':<C-u>Lfilter /^grep: /<CR>'
    # \\ : ':<C-u>Cfilter /^grep: /<CR>'
    # noremap {GREP_DESC[0]}j :<C-u>Sgrep<Space>
    # noremap {GREP_DESC[0]}J :<C-u>Sgrep!<Space>

    # noremap {EGREP_DESC[0]}j :<C-u>Segrep<Space>
    # noremap {EGREP_DESC[0]}J :<C-u>Segrep!<Space>
    # """,
    #     file=f,
    # )
    # print(file=f)
    print('" }}}', file=f)
    print(file=f)
