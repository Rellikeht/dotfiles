local autopairs = require("nvim-autopairs") -- {{{
autopairs.setup(
  {
    -- pandoc ?
    disable_filetype = { --  {{{
      "markdown",
      "text",
      "fzf",
      "fugitive",
    }, --  }}}

    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
  }
)
-- }}}

local cmp = require("cmp") --  {{{
---@diagnostic disable-next-line: unused-local

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
Snippy = require("snippy")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
Capabilities = require("cmp_nvim_lsp").default_capabilities()

-- If you want insert `(` after select function or method item
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- }}}

Snippy.setup( -- {{{
  {
    hl_group = "Comment",

    snippet_dirs = (function()
      local dirs = {}
      -- local snipdirs = vim.api.nvim_list_runtime_paths()
      local snipdirs = {
        NVIM_DIR,
        NVIM_DIR .. "/plugins/vim-snippets",
      }
      for i, e in ipairs(snipdirs) do
        dirs[i] = e .. "/snippets"
        -- print(dirs[i])
      end
      return dirs
    end)(),

    mappings = {
      is = {
        ["<C-j>"] = "next", --
        ["<C-k>"] = "previous",
        ["<C-g>"] = "expand_or_advance",
        ["<C-h>"] = "expand",
        -- ???
        -- ["<C-Space>"] = "complete",
        -- ["<C-Space>"] = function() Snippy.complete() end,
      },

      -- nx = {["<leader>d;"] = "cut_text"},
      nx = {},
    },
  }
)

vim.cmd(
  [[
    autocmd CompleteDone * lua require 'snippy'.complete_done()
]]
)

-- }}}

-- cmp helpers {{{

local cmp_beh = { behavior = cmp.SelectBehavior, count = 1 }

local format = function(entry, vim_item)
  local el = "…"
  local aw = 18
  local mw = 24
  local a = vim_item.abbr and vim_item.abbr or ""
  if #a > aw then vim_item.abbr = string.sub(a, 1, aw) .. el end
  local m = vim_item.menu and vim_item.menu or ""
  if #m > 20 then vim_item.menu = string.sub(m, 1, mw) .. el end
  return vim_item
end

-- TODO B ???
local function scroll_docs_or_open(amount)
  return function(_)
    if cmp.visible_docs() then
      cmp.scroll_docs(amount)
    else
      cmp.open_docs()
    end
  end
end

-- }}}

cmp.setup(
  { -- {{{

    -- {{{
    preselect = cmp.PreselectMode.None,
    window = {
      documentation = { max_width = 0, max_height = 0 },
      completion = { side_padding = 0 },
    },
    -- }}}

    view = { --  {{{
      docs = { auto_open = true },
    }, --  }}}

    formatting = { -- {{{
      fields = { "abbr", "kind", "menu" },
      format = format,
    }, -- }}}

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
      async_budget = 20,
      debounce = 50,
      throttle = 10,
      fetching_timeout = 500,
      max_view_entries = 5000,
      confirm_resolve_timeout = 60,
    }, -- }}}

    mapping = cmp.mapping.preset.insert( -- {{{
      {
        -- basic {{{
        ["<C-e>"] = cmp.mapping.abort(),
        -- }}}

        ["<Tab>"] = { -- {{{
          i = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
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
                cmp.confirm({ select = true })
              else
                cmp.select_next_item(cmp_beh)
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              end
            end
          end,
        }, -- }}}

        ["<S-Tab>"] = { -- {{{
          i = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_prev_item(cmp_beh)
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
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
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm(
              {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              }
            ),
          }
        ), -- }}}

        -- docs {{{

        ["<C-j>"] = cmp.mapping.scroll_docs(1),
        ["<C-k>"] = cmp.mapping.scroll_docs(-1),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(8),
        ["<C-b>"] = cmp.mapping.scroll_docs(-8),

        -- Doesn't work
        ["<C-s>"] = cmp.mapping.open_docs(),
        -- ["<C-j>"] = scroll_docs_or_open(1),
        -- ["<C-k>"] = scroll_docs_or_open(-1),
        -- ["<C-d>"] = scroll_docs_or_open(4),
        -- ["<C-u>"] = scroll_docs_or_open(-4),
        -- ["<C-f>"] = scroll_docs_or_open(8),
        -- ["<C-b>"] = scroll_docs_or_open(-8),

        -- }}}

      }
    ), -- }}}

    completion = { -- {{{
      keyword_length = 2,
      completeopt = "menu,menuone,preview,noselect,noinsert",
    }, -- }}}

    snippet = { -- {{{
      expand = function(args)
        Snippy.expand_snippet(args.body)
      end,
    }, -- }}}

    sources = { -- {{{
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "snippy" },

      { -- {{{
        name = "buffer",
        option = {
          -- below doesn't work sometimes :<
          -- keyword_pattern = [[̨̨\̨k\+]],
          keyword_pattern = "\\([^,./<>?;: \\|\"'{}()\\[\\]" ..
            "!#$%&*-=+	€£¥¢√∇°∞©®∪∩]\\|" ..
            "[A-Z]\\)\\+",
          -- because this fucking shit can't even understand that something
          -- that matches [A-Z]* isn't special characters specified above
          -- totally lovely chinise shit

          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      }, -- }}}

      { name = "omni" },
      { name = "path" },
      { name = "vimtex" },
      { name = "mkdnflow" },
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
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
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
                cmp.confirm({ select = true })
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
                cmp.confirm({ select = true })
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
      { { name = "path" } }, { { name = "cmdline" } },
      { { name = "bufname" } }
    ), -- }}}
  }
) -- }}}

cmp.setup.cmdline(
  "/", { -- {{{
    preselect = cmp.PreselectMode.None,
    -- view = {entries = {name = "wildmenu", separator = " | "}},

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
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              end
            end
          end,
        }, -- }}}

        ["<S-Tab>"] = { -- {{{
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_prev_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
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
