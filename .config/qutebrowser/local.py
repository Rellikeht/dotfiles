# ============================================================
# PRIVACY RELATED
# ============================================================

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only.
#   This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only,
#   unless a cookie is already set for the domain. On QtWebEngine,
#   this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.

config.set("content.cookies.accept", "never", "*")
config.set(
    "content.cookies.accept", "no-unknown-3rdparty", "chrome-devtools://*"
)
config.set("content.cookies.store", True)
config.set("content.cookies.accept", "no-unknown-3rdparty", "devtools://*")

COOKIES = [
    "https://search.rhscz.eu/*",
    "https://searx.stream/*",
    "https://searx.rhscz.eu/*",
    "https://searx.oloke.xyz/*",
    "https://search.inetol.net/*",
    "https://search.hbubli.cc/*",
    "https://search.bladerunn.in/*",
    "https://metacat.online/*",
    "https://searx.foobar.vip/*",
    "https://searx.tuxcloud.net/*",

    # old
    "https://paulgo.io/*",
    "https://searx.be/*",
    "https://priv.au/*",
]

for page in COOKIES:
    config.set("content.cookies.accept", "all", page)

config.set("content.canvas_reading", False)
config.set("content.javascript.enabled", False, "*")

# Enable JavaScript.
JSENABLE = [
    "chrome-devtools://*",
    "devtools://*",
    "chrome://*/*",
    "qute://*/*",
    "*://*.searx.xyz/*",
    "*://*.paulgo.io/*",
    "*://paulgo.io/*",
    "*://*.odysee.com/*",
    "*://odysee.com/*",
    "*://*.youtube.com/*",
    "*://youtube.com/*",
    # Dunno if that is necessary
    "*://github.com/*",
    "*://gitlab.com/*",
    "*://sourceforge.net/*",
    "*://*.github.com/*",
    "*://*.gitlab.com/*",
    "*://*.sourceforge.net/*",
    "*://*.alpinelinux.org/*",
    "*://*.voidlinux.org/*",
    "*://*.archlinux.org/*",
    "*://*.artixlinux.org/*",
    "*://*.nixos.org/*",
    "*://*.freebsd.org/*",
    "*://askubuntu.com/*",
    "*://stackoverflow.com/*",
    "*://serverfault.com/*",
    "*://*.stackoverflow.com/*",
    "*://*.stackexchange.com/*",
    "*://*.superuser.com/*",
    "*://superuser.com/*",
]

for page in JSENABLE:
    config.set("content.javascript.enabled", True, page)

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString #Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
# config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0', 'https://*')
