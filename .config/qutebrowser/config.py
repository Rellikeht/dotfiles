# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# QT flags, currently only for hardware acceleration
config.set('qt.args',
           ['ignore-gpu-blacklist',
            'enable-gpu-rasterization',
            'enable-zero-copy',
            #'enable-native-gpu-memory-buffers',
            'disable-gpu-driver-bug-workarounds',
            'use-gl=egl',
            'num-raster-threads=4',
            'enable-features=VaapiVideoDecoder',
            'enable-features=VaapiIgnoreDriverChecks',
            'disable-features=UseChromeOSDirectVideoDecoder',
            ])

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
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.

config.set('content.cookies.accept', 'never', '*')
config.set('content.cookies.accept', 'no-unknown-3rdparty', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'https://searx.info/*')
config.set('content.cookies.accept', 'all', 'https://searx.xyz/*')
config.set('content.cookies.accept', 'all', 'https://paulgo.io/*')
config.set('content.cookies.store', True)

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
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'no-unknown-3rdparty', 'devtools://*')

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
#config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0', 'https://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True)

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', False, '*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.canvas_reading', False)

config.set('hints.chars', 'asdfjkl;')

config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.unbind('H', mode='normal')
config.unbind('L', mode='normal')
config.unbind('gJ', mode='normal')
config.unbind('gK', mode='normal')

config.bind('H', 'tab-prev', mode='normal')
config.bind('L', 'tab-next', mode='normal')
config.bind('gl', 'tab-move +', mode='normal')
config.bind('gh', 'tab-move -', mode='normal')
config.bind('J', 'back', mode='normal')
config.bind('K', 'forward', mode='normal')

#config.bind('<Ctrl+r>', 'restart', mode='normal')
config.bind('<Ctrl+o>', 'set-cmd-text -s :open -b', mode='normal')
config.bind('ps', 'insert-text {primary}')
config.bind('ys', 'yank selection')

config.bind(',dm', 'open -t qute://log/?level=info')
config.bind(',db', 'open -t qute://bindings/')
config.bind(',dg', 'open -t chrome://gpu/')
config.bind(',dh', 'open -t qute://help/index.html')
config.bind(',dH', 'open -t qute://history')

config.bind(',m', 'spawn smplayer "{url}"', mode='normal')
config.bind(',M', 'hint links spawn -d smplayer "{hint-url}"')
config.bind(',s', 'config-cycle statusbar.show always never')
config.bind(',t', 'config-cycle tabs.show always never')
config.bind(',e', 'hint links spawn -d sh -c "wget -O - "{url}" | gsvim -"')
config.bind(',E', 'spawn -d sh -c "wget -O - "{url}" | gsvim -"')
config.bind(',r', 'hint links spawn -d sh -c "wget -O - "{url}" | w3m -T text/html -dump | gsvim -"')
config.bind(',R', 'spawn -d sh -c "wget -O - "{url}" | w3m -T text/html -dump | gsvim -"')
config.bind(',v', 'spawn -d vlc "{url}"')
config.bind(',V', 'hint links spawn -d vlc "{hint-url}"')

config.bind(',NH', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=1080]+bestaudio" "{hint-url}"')
config.bind(',NL', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=360]+bestaudio" "{hint-url}"')
config.bind(',NM', 'hint links spawn -d mpv --ytdl-format="bestaudio" --player-operation-mode=pseudo-gui "{hint-url}"')
config.bind(',Nh', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=720]+bestaudio" "{hint-url}"')
config.bind(',Nl', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=480]+bestaudio" "{hint-url}"')
config.bind(',Nm', 'hint links spawn -d mpv "{hint-url}"')
config.bind(',Nq', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=1440]+bestaudio" "{hint-url}"')
config.bind(',nH', 'spawn -d mpv --ytdl-format="bestvideo[height<=1080]+bestaudio" "{url}"')
config.bind(',nL', 'hint links spawn -d mpv --ytdl-format="bestvideo[height<=360]+bestaudio" "{url}"')
config.bind(',nM', 'spawn -d mpv --ytdl-format="bestaudio" --player-operation-mode=pseudo-gui "{url}"')
config.bind(',nh', 'spawn -d mpv --ytdl-format="bestvideo[height<=720]+bestaudio" "{url}"')
config.bind(',nl', 'spawn -d mpv --ytdl-format="bestvideo[height<=480]+bestaudio" "{url}"')
config.bind(',nm', 'spawn -d mpv "{url}"')
config.bind(',nq', 'spawn -d mpv --ytdl-format="bestvideo[height<=1440]+bestaudio" "{url}"')

config.unbind('D', mode="normal")
config.bind('Db', 'set-cmd-text -s :bookmark-del')
config.bind('Dq', 'set-cmd-text -s :quickmark-del')
config.bind('gS', 'config-source')
config.bind('gM', 'messages -t')
config.bind('gE', 'config-diff')
config.bind('gc', 'config-edit')

config.bind('cg', 'set-cmd-text -s :tab-give')
config.bind('cm', 'clear-messages')
config.bind('ca', 'adblock-update')

#config.bind(',', '')
#good commands:
#spawn - external command
#hint - highlight some element for selecting
#set-cmd-text - type some command and wait for user to execute it
#config-cycle - cycle through valuses of some config option

#config.set('editor.command', ['gsvim', '-c', 'normal {line}G{column0}1', '{file}'])
config.set('editor.command', ['st', 'svim', '{file}'])

import dracula.draw
dracula.draw.blood(c, {
    'spacing': {
        'vertical': 4,
        'horizontal': 6
    }
})

config.set('colors.webpage.darkmode.algorithm',  'lightness-hsl')
config.set('colors.webpage.darkmode.contrast',  0.0)
config.set('colors.webpage.darkmode.policy.images',  'never')
config.set('colors.webpage.darkmode.enabled', True)
config.set('fonts.default_size', '12pt')
config.set('messages.timeout', 1200)

config.set('content.media.audio_capture', 'ask')
config.set('content.media.audio_video_capture', 'ask')
config.set('content.media.video_capture', 'ask')
config.set('downloads.prevent_mixed_content', False)
config.set('new_instance_open_target', 'tab')
config.set('statusbar.show', 'always')
config.set('tabs.background', True)
config.set('tabs.show', 'multiple')
config.set('statusbar.show', 'in-mode')

config.set('content.cache.size', 67108864)
config.set('content.media.audio_capture', True, 'https://discord.com')

DEFAULT_SEARX = 'https://paulgo.io'

config.set('url.start_pages', DEFAULT_SEARX)
config.set('url.default_page', DEFAULT_SEARX)
config.set('url.searchengines',
           {
               'DEFAULT':DEFAULT_SEARX+'/search?q={}',
               'sb':'https://searx.xyz/search?q={}',
               'ps':DEFAULT_SEARX+'/search?q={}&language=pl-PL',
               'pb':'https://searx.xyz/search?q={}&language=pl-PL',

               'aw':'https://wiki.archlinux.org/index.php?search={}',
               'gw':'https://wiki.gentoo.org/index.php?search={}',
               'wc':'https://wikichip.org/wiki?search={}',

               'au':'https://aur.archlinux.org/packages?K={}&PP=250&SB=n&SO=a',
               'ap':'https://archlinux.org/packages/?q={}',
               'gp':'https://packages.gentoo.org/packages/search?q={}',
               'np':'https://search.nixos.org/packages?size=500&query={}',

               'gh':'https://github.com/search?q={}',
               'sf':'https://sourceforge.net/directory/?clear&q={}',

               'yt':'https://youtube.com/results?search_query={}',
               'lb':'https://odysee.com/$/search?q={}',

               'pp':'https://pypi.org/search/?q={}',
               'jp':'https://juliapackages.com/packages?search={}',
               })

#Javascript in search engines and other useful websites
config.set('content.javascript.enabled', True, 'https://searx.xyz/*')
config.set('content.javascript.enabled', True, 'https://paulgo.io/*')
config.set('content.javascript.enabled', True, 'https://odysee.com/*')
config.set('content.javascript.enabled', True, 'https://youtube.com/*')
config.set('content.javascript.enabled', True, 'https://github.com/*')
config.set('content.javascript.enabled', True, 'https://gitlab.com/*')
config.set('content.javascript.enabled', True, 'https://sourceforge.net/*')
config.set('content.javascript.enabled', True,  '*://*.docs.voidlinux.org/*')
config.set('content.javascript.enabled', True,  '*://*.pkgs.alpinelinux.org/*')
config.set('content.javascript.enabled', True,  '*://*.voidlinux.org/*')
config.set('content.javascript.enabled', True,  '*://*.archlinux.org/*')
config.set('content.javascript.enabled', True,  '*://wiki.archlinux.org/*')
config.set('content.javascript.enabled', True,  '*://aur.archlinux.org/*')
config.set('content.javascript.enabled', True,  '*://*.artixlinux.org/*')
config.set('content.javascript.enabled', True,  '*://www.deepl.com/*')

# AUTOCONFIG!!!
# I use it as local configuration
# (different for different machines/systems)
# and this file as global
config.load_autoconfig()
