# ============================================================
# SOME HARD STUFF
# ============================================================

# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# from typing import Any

# THIS IS FUCKED
from qutebrowser.config.configfiles import ConfigAPI  # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

import dracula.draw as draw

# ??
config: ConfigAPI = config
c: ConfigContainer = c

# QT flags, currently only for hardware acceleration
config.set(
    "qt.args",
    [  # {{{
        "ignore-gpu-blocklist",
        "enable-gpu-rasterization",
        "enable-zero-copy",
        "enable-vulkan",
        "enable-native-gpu-memory-buffers",
        "disable-gpu-driver-bug-workarounds",
        # "use-gl=egl",
        "num-raster-threads=4",
        "enable-features=VaapiVideoDecoder",
        "enable-features=VaapiIgnoreDriverChecks",
        "disable-features=UseChromeOSDirectVideoDecoder",
    ],  # }}}
)

# {{{ OTHER SETTINGS

# Load images automatically in web pages.
config.set("content.images", True)

draw.blood(c, {"spacing": {"vertical": 4, "horizontal": 6}})

config.set("colors.webpage.darkmode.algorithm", "lightness-hsl")
config.set("colors.webpage.darkmode.contrast", 0.0)
config.set("colors.webpage.darkmode.policy.images", "never")
config.set("colors.webpage.darkmode.enabled", True)
config.set("fonts.default_size", "12pt")
config.set("messages.timeout", 1200)

config.set("downloads.prevent_mixed_content", False)
config.set("new_instance_open_target", "tab")
config.set("statusbar.show", "always")  # in-mode bugs websites :(
config.set("tabs.background", True)
config.set("tabs.show", "multiple")

config.set("content.cache.size", 67108864)
# }}}

# config.set('editor.command',
#           ['gsvim', '-c', 'normal {line}G{column0}1',
#            '{file}'])
config.set("editor.command", ["st", "svim", "{file}"])

config.set("auto_save.session", True)
config.set("auto_save.interval", 20000)

# ============================================================
# SHORTCUTS
# ============================================================

DEFAULT_SEARX = "https://paulgo.io"

config.set("url.start_pages", DEFAULT_SEARX)
config.set("url.default_page", DEFAULT_SEARX)
config.set(
    "url.searchengines",
    {  # {{{
        "DEFAULT": DEFAULT_SEARX + "/search?q={}",
        "sb": "https://searx.xyz/search?q={}",
        "ps": DEFAULT_SEARX + "/search?q={}&language=pl-PL",
        "pb": "https://searx.xyz/search?q={}&language=pl-PL",
    }  # }}}
    | {  # {{{
        "aw": "https://wiki.archlinux.org/index.php?search={}",
        "gw": "https://wiki.gentoo.org/index.php?search={}",
        "nw": "https://nixos.wiki/index.php?search={}",
        "wc": "https://wikichip.org/wiki?search={}",
    }  # }}}
    | {  # {{{
        "ap": "https://archlinux.org/packages/?q={}",
        "au": "https://aur.archlinux.org/packages?K={}&PP=2500&SB=n&SO=a",
        "auu": "https://aur.archlinux.org/packages?K={}&PP=2500&SB=n&SO=a&outdated=off",
    }  # }}}
    | {  # {{{
        "gp": "https://packages.gentoo.org/packages/search?q={}",
        "np": "https://search.nixos.org/packages?size=500&query={}",
        "no": "https://search.nixos.org/options?size=500&query={}",
    }  # }}}
    | {  # {{{
        "fp": "https://ports.freebsd.org/cgi/ports.cgi?query={}&stype=all",
        "fpn": "https://ports.freebsd.org/cgi/ports.cgi?query={}&stype=name",
        "fpd": "https://ports.freebsd.org/cgi/ports.cgi?query={}&stype=text",
    }  # }}}
    | {  # {{{
        "gh": "https://github.com/search?q={}",
        "sf": "https://sourceforge.net/directory/?clear&q={}",
    }  # }}}
    | {  # {{{
        "pp": "https://pypi.org/search/?q={}",
        "jp": "https://juliapackages.com/packages?search={}",
    }  # }}}
    | {  # {{{
        "yt": "https://youtube.com/results?search_query={}",
        "lb": "https://odysee.com/$/search?q={}",
    }  # }}}
    | {  #  {{{
        "ss": "https://searchmysite.net/search?q={}",
        "cl": "https://curlie.org/search?q={}",
    },  #  }}}
)

# ============================================================
# BINDINGS
# ============================================================

config.set("hints.chars", "asdfjkl;")

config.unbind("J", mode="normal")
config.unbind("K", mode="normal")
config.unbind("H", mode="normal")
config.unbind("L", mode="normal")
config.unbind("gJ", mode="normal")
config.unbind("gK", mode="normal")

config.bind("H", "tab-prev", mode="normal")
config.bind("L", "tab-next", mode="normal")
config.bind("gl", "tab-move +", mode="normal")
config.bind("gh", "tab-move -", mode="normal")
config.bind("J", "back", mode="normal")
config.bind("K", "forward", mode="normal")

# config.bind('<Ctrl+r>', 'restart', mode='normal')
config.bind("<Ctrl+o>", "cmd-set-text -s :open -b", mode="normal")
config.bind("ps", "insert-text {primary}")
config.bind("ys", "yank selection")

config.bind(",dm", "open -t qute://log/?level=info")
config.bind(",db", "open -t qute://bindings/")
config.bind(",dg", "open -t chrome://gpu/")
config.bind(",dh", "open -t qute://help/index.html")
config.bind(",dH", "open -t qute://history")

config.bind(",s", "config-cycle statusbar.show always never")
config.bind(",t", "config-cycle tabs.show always never")
config.bind(
    ",e", 'hint links spawn -d sh -c "wget -O - "{hint-url}" | gsvim -"'
)
config.bind(",E", 'spawn -d sh -c "wget -O - "{url}" | gsvim -"')
config.bind(
    ",r",
    'hint links spawn -d sh -c "wget -O - "{hint-url}" | w3m -T text/html -dump | gsvim -"',
)
config.bind(
    ",R",
    'spawn -d sh -c "wget -O - "{url}" | w3m -T text/html -dump | gsvim -"',
)
config.bind(",v", 'spawn -d vlc "{url}"')
config.bind(",V", 'hint links spawn -d vlc "{hint-url}"')

combs = [
    # {{{
    ("M", "gaudio"),
    ("m", "default"),
    ("S", "14"),
    ("s", "24"),
    ("l", "48"),
    ("L", "36"),
    ("h", "hd"),
    ("H", "fh"),
    ("q", "qh"),
    ("4", "4k"),
    # TODO do that better somehow
    ("b", "hdb"),
    ("B", "hdf"),
    ("f", "fhb"),
    ("F", "fhf"),
]  # }}}

for key, profile in combs:
    config.bind(f",M{key}", f'spawn -d mpv --profile={profile} "{{url}}"')
    config.bind(
        f",m{key}",
        f'hint links spawn -d mpv --profile={profile} "{{hint-url}}"',
    )

config.unbind("D", mode="normal")
config.bind("Db", "cmd-set-text -s :bookmark-del")
config.bind("Dq", "cmd-set-text -s :quickmark-del")
config.bind("gS", "config-source")
config.bind("gM", "messages -t")
config.bind("gE", "config-diff")
config.bind("gc", "config-edit")

config.bind("cg", "cmd-set-text -s :tab-give")
config.bind("cm", "clear-messages")
config.bind("ca", "adblock-update")

c.aliases["sl"] = "session-load"
c.aliases["sS"] = "session-save --current"
c.aliases["ss"] = "session-save --current --only-active-window"

config.bind("sw", "session-save --current --only-active-window")
config.bind("sW", "session-save --current")

# good commands:
# spawn - external command
# hint - highlight some element for selecting
# cmd-set-text - type some command and wait for user to execute it
# config-cycle - cycle through valuses of some config option

# ============================================================
# PRIVACY RELATED
# ============================================================

config.set("content.media.audio_capture", "ask")
config.set("content.media.audio_video_capture", "ask")
config.set("content.media.video_capture", "ask")

config.set("content.media.audio_capture", True, "https://discord.com")

# ============================================================
# LOCAL
# ============================================================
# with open("local.py") as local:
#     eval(local.read())
# import local
config.source("local.py")

# AUTOCONFIG!!!
# I use it as local configuration
# (different for different machines/systems)
# and this file as global
config.load_autoconfig()
