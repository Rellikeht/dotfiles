local settings = require("settings")

settings.application.prefer_dark_mode = true
for s, v in pairs({
  enable_accelerated_2d_canvas = true,
  hardware_acceleration_policy = "always",
  enable_webgl = true
}) do settings.webview[s] = v end

settings.window.search_engines = {
  default = "https://qwant.com/search?q=%s",
  searx = "http://www.paulgo.io/search?q=%s",
  duckduckgo = "https://duckduckgo.com/?q=%s",
  github = "https://github.com/search?q=%s",
  google = "https://google.com/search?q=%s"
}

dofile(luakit.config_dir .. "/binds.lua")
