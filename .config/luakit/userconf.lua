local settings = require("settings")

settings.application.prefer_dark_mode = true
for s, v in pairs({
  enable_accelerated_2d_canvas = true,
  hardware_acceleration_policy = "always",
  enable_webgl = true
}) do settings.webview[s] = v end

dofile(luakit.config_dir .. "/binds.lua")
