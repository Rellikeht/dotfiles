-- {{{ harpoon
local harpoon = require("harpoon") -- {{{
harpoon:setup(
  {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
      -- What?
      -- key = function() return vim.loop.cwd() end,
    },
  }
)
-- }}}

vim.keymap.set(
  {"n", "v"}, "<Space>ja", function() harpoon:list():add() end
)
vim.keymap.set(
  {"n", "v"}, "<Space>jl",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
)
-- TODO B quickfix

-- {{{ select nth
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
-- }}}

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set(
  {"n", "v"}, "<C-k>", function() harpoon:list():prev() end
)
vim.keymap.set(
  {"n", "v"}, "<C-j>", function() harpoon:list():next() end
)

-- {{{ TODO A stack operations

-- }}}

harpoon:extend( -- {{{
  {
    UI_CREATE = function(cx)
      vim.keymap.set( -- {{{
        "n", "v", function()
          harpoon.ui:select_menu_item({vsplit = true})
        end, {buffer = cx.bufnr}
      ) -- }}}

      vim.keymap.set( -- {{{
        "n", "s", function()
          harpoon.ui:select_menu_item({split = true})
        end, {buffer = cx.bufnr}
      ) -- }}}

      vim.keymap.set( -- {{{
        "n", "t", function()
          harpoon.ui:select_menu_item({tabedit = true})
        end, {buffer = cx.bufnr}
      ) -- }}}

      -- TODO B quickfix
      -- TODO D preview window
    end,
  }
) -- }}}

-- }}}
