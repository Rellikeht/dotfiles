local autopairs = require("nvim-autopairs") -- {{{ TODO C
autopairs.setup({})
-- }}}

local cmp = require("cmp") -- {{{ 
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
        ["<C-j>"] = "expand_or_advance",
        ["<C-k>"] = "previous",
      },
      -- nx = {["<leader>d;"] = "cut_text"},
      nx = {},
    },
  }
) -- }}}

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
        -- {{{
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({select = true}),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- }}}

        -- ["<CR>"] = cmp.mapping.confirm({select = false}),
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

        ["<C-n>"] = cmp.mapping( -- {{{
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item(
                {behavior = cmp.SelectBehavior, count = 1}
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
                {behavior = cmp.SelectBehavior, count = 1}
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
      {name = "nvim_lua"},
      {name = "nvim_lsp"},
      {name = "nvim_lsp_signature_help"},
      {name = "snippy"},

      { -- {{{
        name = "buffer",
        option = {
          -- TODO C 'iskeyword'
          -- keyword_pattern = [[̨̨\̨k\+]],
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      }, -- }}}
      {name = "omni"},
      {name = "path"},
      {name = "vimtex"},
    }, -- }}}
  }
)

-- }}}

-- questionable thing
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
      -- keyword_length = 2,
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

        ["<Tab>"] = cmp.config.disable,
        ["<S-Tab>"] = cmp.config.disable,
      }
    ), -- }}}

    sources = cmp.config.sources( -- {{{
      {{name = "path"}}, {{name = "cmdline"}},
      {{name = "bufname"}}
    ), -- }}}
  }
) -- }}}

-- very questionable
cmp.setup.cmdline(
  "/", { -- {{{
    preselect = cmp.PreselectMode.None,
    -- view = {entries = {name = "wildmenu", separator = " | "}},

    completion = { -- {{{
      -- keyword_length = 2,
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

        -- ["<Tab>"] = { -- {{{
        --   c = function()
        --     vim.api.nvim_feedkeys(
        --       vim.api.nvim_replace_termcodes(
        --         "<Tab>", true, false, true
        --       ), "tn", false
        --     )
        --   end,
        -- }, -- }}}
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
