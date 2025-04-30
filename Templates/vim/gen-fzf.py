#!/usr/bin/env python
from sys import argv  # , stdout
from os.path import split
from pathlib import Path

MAP_START = "<Leader>s"

FZF_PATHS = {
    "h": "~",
    "t": "~/Templates",
    "d": "~/Dbackup",
    "D": "~/Downloads",
    "f": "~/Documents",
    "p": "~/gits",
    "cc": "~/.config",
    "cv": "~/.vim",
    "cn": "~/.config/nvim",
    ".": ".",
    # ",": ".",
}
FZF_PATHS.update(
    dict(map(lambda n: (str(n), ".." + "/.." * (n - 1)), range(1, 10)))
)

FZF_SPECIALS = {
    "g": "GitRoot()",
    "G": "GitRoot(GitRoot().'/..')",
    "m": "HgRoot()",
    "M": "HgRoot(HgRoot().'/..')",
    "r": "PartRoot()",
    "b": "g:starting_path",
    "e": "EnvrcRoot()",
    "E": "EnvrcRoot(EnvrcRoot().'/..')",
    "<C-e>": "EnvrcRoot(EnvrcRoot(EnvrcRoot().'/..').'/..')",
}

# TODO C some selection and <cwhatever>

OP_MAPS = {
    "p": "Files",
    "s": "Dah",
    "S": "Dau",
    "g": "Dgrep",
    "G": "Digrep",
    "r": "Drg",
    "R": "Dru",
}

SCRIPT_PATH = Path(split(argv[0])[0])
VIM_PATH = SCRIPT_PATH / ".." / ".." / ".vim" / "plug-handlers"

# with stdout as f:
with open(VIM_PATH / "fzf.vim", "w") as f:
    with open(SCRIPT_PATH / "fzf.vim", "r") as template:
        print(template.read(), file=f)
        print(file=f)

    print('" path maps {{{', file=f)
    print(file=f)

    print('" empty cmds', file=f)
    for op_key, op in OP_MAPS.items():
        for add_key in ["<Space>", "<CR>"]:
            print(
                f"nnoremap {MAP_START}{op_key}{add_key} :<C-u>{op}{add_key}",
                file=f,
            )
    print(file=f)

    for path_key, path in FZF_PATHS.items():
        for op_key, op in OP_MAPS.items():
            print(
                f"nnoremap {MAP_START}{op_key}{path_key} "
                + f":<C-u>{op} {path}<CR>",
                file=f,
            )
        print(file=f)
    print(file=f)

    for path_key, path in FZF_SPECIALS.items():
        for op_key, op in OP_MAPS.items():
            print(
                f"nnoremap {MAP_START}{op_key}{path_key} "
                + f":<C-u> exe '{op} '.{path}<CR>",
                file=f,
            )
        print(file=f)

    print('" }}}', file=f)
