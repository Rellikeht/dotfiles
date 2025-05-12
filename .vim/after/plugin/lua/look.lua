-- COLORIZER {{{
local col_css_conf = {
  css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  names = true,
}

local col_vim_conf = { names = true }

require("colorizer").setup(
  {
    "*",
    html = col_css_conf,
    css = col_css_conf,
    js = col_css_conf,
    ts = col_css_conf,
    vim = col_vim_conf,
    lua = col_vim_conf,
  }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode = "background", -- Set the display mode.
  }
)

nkeymap(
  "<Leader>qct", ":<C-u>ColorizerToggle<CR>", { noremap = true }
)
vkeymap(
  "<Leader>qct", ":<C-u>ColorizerToggle<CR>gv",
  { noremap = true }
)
keymap(
  "<Leader>qcT", "<Leader>qct<Leader>qct", { noremap = true }
)

nkeymap(
  "<Leader>qcr", ":<C-u>ColorizerReloadAllBuffers<CR>",
  { noremap = true }
)
vkeymap(
  "<Leader>qcr", ":<C-u>ColorizerReloadAllBuffers<CR>gv",
  { noremap = true }
)

-- }}}

-- TODO C colors {{{
vim.cmd("hi Todo		guifg=#ffcf2f	guibg=#0e1224	gui=bold")
-- vim.api.nvim_set_hl(0, "Todo", {
--   fg="#ffcf2f",
--   bg="#0e1224",
--   bold=true,
-- })

-- TODO fucking todo can't change it's color
-- easy to use plugin they say
-- vim.api.nvim_set_hl(0, '@text.todo', { link = 'Todo' })
-- vim.api.nvim_command('hi Todo guifg=#ff0000 guibg=#ff0000 gui=bold')
-- }}}
