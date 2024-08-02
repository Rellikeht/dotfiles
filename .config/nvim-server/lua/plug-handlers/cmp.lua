local autopairs = require("nvim-autopairs") -- {{{
autopairs.setup({})
-- }}}

local cmp = require("cmp") -- {{{ 
---@diagnostic disable-next-line: unused-local

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- If you want insert `(` after select function or method item
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- }}}

local cmp_beh = {behavior = cmp.SelectBehavior, count = 1}
cmp.setup(
  { -- {{{
    preselect = cmp.PreselectMode.None,

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

    performance = { -- {{{
      async_budget = 10,
      debounce = 50,
      throttle = 10,
      fetching_timeout = 300,
      max_view_entries = 1000,
      confirm_resolve_timeout = 50,
    }, -- }}}

    mapping = cmp.mapping.preset.insert( -- {{{
      {
        -- {{{ basic
        ["<C-e>"] = cmp.mapping.abort(),
        -- }}}

        ["<Tab>"] = { -- {{{
          i = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_next_item(cmp_beh)
              end
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                  "<Tab>", true, false, true
                ), "tn", false
              )
            end
          end,
        }, -- }}}

        ["<C-Space>"] = { -- {{{
          i = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_next_item(cmp_beh)
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              end
            end
          end,
        }, -- }}}

        ["<S-Tab>"] = { -- {{{
          i = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_prev_item(cmp_beh)
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_prev_item(cmp_beh)
              end
            end
          end,
        }, -- }}}

        ["<C-n>"] = { -- {{{
          i = function(fallback)
            if cmp.visible() then
              cmp.select_next_item(cmp_beh)
            else
              fallback()
            end
          end,
        }, -- }}}

        ["<C-p>"] = { -- {{{
          i = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(cmp_beh)
            else
              fallback()
            end
          end,
        }, -- }}}

        ["<CR>"] = cmp.mapping( -- {{{
          {
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm(
                  {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                  }
                )
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({select = true}),
            c = cmp.mapping.confirm(
              {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              }
            ),
          }
        ), -- }}}

        -- {{{ docs
        ["<C-j>"] = cmp.mapping.scroll_docs(1),
        ["<C-k>"] = cmp.mapping.scroll_docs(-1),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(8),
        ["<C-b>"] = cmp.mapping.scroll_docs(-8),
        -- }}}

      }
    ), -- }}}

    completion = { -- {{{
      keyword_length = 2,
      completeopt = "menu,menuone,preview,noselect,noinsert",
    }, -- }}}

    sources = { -- {{{
      {name = "nvim_lua"},

      { -- {{{
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      }, -- }}}
      {name = "omni"},
      {name = "path"},
    }, -- }}}
  }
)

-- }}}

cmp.setup.cmdline(
  ":", { -- {{{
    preselect = cmp.PreselectMode.None,

    performance = { -- {{{
      async_budget = 10,
      debounce = 50,
      throttle = 10,
      fetching_timeout = 300,
      max_view_entries = 1000,
      confirm_resolve_timeout = 50,
    }, -- }}}

    completion = { -- {{{
      -- keyword_length = 3,
      autocomplete = false,
      completeopt = "menu,preview,noselect,noinsert",
    }, -- }}}

    mapping = cmp.mapping.preset.cmdline( -- {{{
      {
        ["<C-Space>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_next_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              end
            end
          end,
        }, -- }}}

        ["<C-c>"] = { -- {{{
          c = function()
            if cmp.visible() then
              cmp.close()
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                  "<C-c>", true, true, true
                ), "n", true
              )
            end
          end,
        },
        -- }}}

        ["<Tab>"] = { -- {{{
          c = function()
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_next_item()
              end
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                  "<Tab>", true, false, true
                ), "tn", false
              )
            end
          end,
        }, -- }}}

        ["<S-Tab>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_prev_item(cmp_beh)
              end
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                  "<S-Tab>", true, false, true
                ), "tn", false
              )
            end
          end,
        }, -- }}}

      }
    ), -- }}}

    sources = cmp.config.sources( -- {{{
      {{name = "path"}}, {{name = "cmdline"}},
      {{name = "bufname"}}
    ), -- }}}
  }
) -- }}}

cmp.setup.cmdline(
  "/", { -- {{{
    preselect = cmp.PreselectMode.None,

    completion = { -- {{{
      -- keyword_length = 3,
      autocomplete = false,
      completeopt = "menu,preview,noselect,noinsert",
    }, -- }}}

    performance = { -- {{{
      -- TODO C this is slow
      async_budget = 5,
      debounce = 20,
      throttle = 20,
      fetching_timeout = 50,
      max_view_entries = 400,
      confirm_resolve_timeout = 50,
    }, -- }}}

    mapping = cmp.mapping.preset.cmdline(
      {
        ["<C-c>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              cmp.close()
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(
                  "<C-c>", true, true, true
                ), "n", true
              )
            end
          end,
        },
        -- }}}

        ["<Tab>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_next_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              end
            end
          end,
        }, -- }}}

        ["<S-Tab>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_prev_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({select = true})
              else
                cmp.select_prev_item()
              end
            end
          end,
        }, -- }}}
      }
    ),

    sources = { -- {{{
      { -- {{{
        name = "buffer",
        -- only visible buffers
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
      }, -- }}}
    }, -- }}}
  }
) -- }}}
