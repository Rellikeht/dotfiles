local settings = require("settings")
local modes = require("modes")

modes.remap_binds("normal", {{"<C-\\>", "H"}})
modes.remap_binds("normal", {{"H", "K"}})
modes.remap_binds("normal", {{"K", "<C-\\>"}})

modes.remap_binds("normal", {{"<C-\\>", "L"}})
modes.remap_binds("normal", {{"L", "J"}})
modes.remap_binds("normal", {{"J", "<C-\\>"}})

modes.remap_binds("normal", {{"<C-\\>", "K"}})
modes.remap_binds("normal", {{"K", "J"}})
modes.remap_binds("normal", {{"J", "<C-\\>"}})
