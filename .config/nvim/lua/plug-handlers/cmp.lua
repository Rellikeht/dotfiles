local autopairs = require("nvim-autopairs") -- {{{ TODO C
autopairs.setup({})
-- }}}

local cmp = require("cmp") -- {{{ 
---@diagnostic disable-next-line: unused-local

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local snippy = require("snippy")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
Capabilities = require("cmp_nvim_lsp").default_capabilities()

-- If you want insert `(` after select function or method item
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- }}}

snippy.setup(
  { -- {{{
    -- Because of (shit) cmp
    mappings = {is = {}, nx = {}},
  }
)
-- }}}

cmp.setup(
  {
    preselect = cmp.PreselectMode.None,
    completeopt = "menu,menuone,noselect,noinsert",

    enabled = function() -- {{{
      local context = require("cmp.config.context")
      local mode = vim.api.nvim_get_mode().mode
      if mode == "c" then
        return true
      else
        return not context.in_syntax_group("Comment") and
                 not context.in_syntax_group("String")
      end
    end, -- }}}

    mapping = cmp.mapping.preset.insert( -- {{{
      {
        -- {{{
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({select = false}),
        ["<Tab>"] = cmp.mapping.confirm({select = true}),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- }}}

        ["<C-n>"] = cmp.mapping( -- {{{
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item(
                {
                  --
                  behavior = cmp.SelectBehavior,
                  count = 1,
                }
              )
            else
              fallback()
            end
          end, {"i", "s"}
        ), -- }}}

        ["<C-p>"] = cmp.mapping( -- {{{
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(
                {
                  --
                  behavior = cmp.SelectBehavior,
                  count = 1,
                }
              )
            else
              fallback()
            end
          end, {"i", "s"}
        ), -- }}}

        -- {{{
        ["<C-j>"] = cmp.mapping.scroll_docs(1),
        ["<C-k>"] = cmp.mapping.scroll_docs(-1),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(8),
        ["<C-b>"] = cmp.mapping.scroll_docs(-8),
        -- }}}

      }
    ), -- }}}

    snippet = { -- {{{
      expand = function(args)
        snippy.expand_snippet(args.body)
      end,
    }, -- }}}

    sources = { -- {{{
      {name = "nvim_lua"},
      {name = "nvim_lsp"},
      {name = "nvim_lsp_signature_help"},
      {name = "buffer"},
      {name = "snippy"},
    }, -- }}}
  }
)
