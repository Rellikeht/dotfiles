-- {{{ harpoon
-- TODO add magic like in readme of repo
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set(
  {"n", "v"}, "<Space>ja", function() harpoon:list():add() end
)
vim.keymap.set(
  {"n", "v"}, "<Space>jl",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
)

vim.keymap.set(
  {"n", "v"}, "<Space>j1",
  function() harpoon:list():select(1) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j2",
  function() harpoon:list():select(2) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j3",
  function() harpoon:list():select(3) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j4",
  function() harpoon:list():select(4) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j5",
  function() harpoon:list():select(5) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j6",
  function() harpoon:list():select(6) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j7",
  function() harpoon:list():select(7) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j8",
  function() harpoon:list():select(8) end
)
vim.keymap.set(
  {"n", "v"}, "<Space>j9",
  function() harpoon:list():select(9) end
)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set(
  {"n", "v"}, "<C-k>", function() harpoon:list():prev() end
)
vim.keymap.set(
  {"n", "v"}, "<C-j>", function() harpoon:list():next() end
)

-- }}}
