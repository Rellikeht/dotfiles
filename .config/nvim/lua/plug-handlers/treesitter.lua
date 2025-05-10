---@diagnostic disable: undefined-global, missing-fields
require("nvim-treesitter.install").prefer_git = false

local tskey = "<Leader>a"
local gid = vim.api.nvim_create_augroup(
  "treesitter_load_group", {}
)

-- just load treesitter after drawing window because it is very slow
-- and nobody seems to know why
vim.api.nvim_create_autocmd(
  { "CursorHold" }, {
    pattern = "*",
    group = gid,
    callback = function()
      vim.api.nvim_del_augroup_by_id(gid)

      -- there is so much of that shit
      require("nvim-treesitter.configs").setup(
        {
          ensure_installed = { -- {{{
            -- basic
            "lua",
            "luap",
            "vim",
            "vimdoc", -- notes and text
            "markdown",
            "markdown_inline",
            "comment",
            "todotxt",
            "diff",
            "regex",
            "org",
            "norg",
            "ebnf",
            -- main
            "c",
            "ocaml",
            "ocaml_interface",
            "menhir",
            "commonlisp",
            "go",
            "gomod",
            "scheme",
            "nim",
            "nim_format_string",
            "nix",
            "julia",
            "haskell",
            "zig",
            "python",
            "typst",
            -- not that necessary
            "perl",
            "html",
            "css",
            "nickel",
            "rust",
            "make",
            "ninja",
            "meson",
            "cmake",
            "cpp",
            "sql",
            "tcl",
            "odin",
            "erlang",
            "elixir",
            -- data
            "json",
            "jsonc",
            "xml",
            "csv",
            "tsv",
            -- configs
            "query",
            "ini",
            "toml",
            "yaml",
            "tmux",
            "zathurarc",
            "rasi",
            "ssh_config",
            "udev",
            -- why is that shit here...
            "fortran",
            "verilog",
            "vhdl",
            "scala",
            "ada",
            "roc",
            "kotlin",
            "clojure",
            "java",
            "forth",
            "cuda",
            -- "prolog",
            "javascript",
            "typescript",
            -- git
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            -- shell
            "powershell",
            "bash",
            "awk",
            -- other
            "dockerfile",
            "dot",
            -- need node :(
            -- "ocamllex", "latex",

          }, -- }}}

          -- some settings {{{
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = false,
          -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers",
          -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
          incremental_selection = { enable = true },

          indent = { enable = true },
          -- }}}

          highlight = { -- {{{
            enable = true,
            -- Use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            -- disable = function(lang, buf)
            --   local max_filesize = 100 * 1024 -- 100 KB
            --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --   if ok and stats and stats.size > max_filesize then return true end
            -- end,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          }, -- }}}

          textobjects = {
            lsp_interop = { -- {{{
              enable = true,
              border = "none",
              floating_preview_opts = {},

              peek_definition_code = { -- {{{
                -- TODO more ??
                ["<leader>dzf"] = "@function.outer",
                ["<leader>dzc"] = "@class.outer",
                ["<leader>dza"] = "@assignment.outer",
              }, -- }}}
            }, -- }}}

            select = { -- {{{
              -- {{{
              enable = true, --
              lookahead = true, --
              -- }}}
              keymaps = { -- {{{
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer", --
                ["if"] = "@function.inner", --
                ["aF"] = "@method.outer", --
                ["iF"] = "@method.inner", --
                ["as"] = "@conditional.outer",
                ["is"] = "@conditional.inner",
                ["aa"] = "@parameter.outer", --
                ["ia"] = "@parameter.inner", --
                ["am"] = "@macro.outer", --
                ["im"] = "@macro.inner", --
                ["aM"] = "@define.outer", --
                ["iM"] = "@define.inner", --
                ["a#"] = "@comment.outer", --
                ["i#"] = "@comment.inner", --
                ["a\""] = "@string.outer", --
                ["i\""] = "@string.inner", --
                ["al"] = "@loop.outer", --
                ["il"] = "@loop.inner", --
                ["aL"] = "@repeat.outer", --
                ["iL"] = "@repeat.inner", --
                ["aed"] = "@exception.outer", --
                ["ied"] = "@exception.inner", --
                ["an"] = "@namespace.outer", --
                ["in"] = "@namespace.inner", --
                ["au"] = "@include.outer", --
                ["iu"] = "@include.inner", --
                ["at"] = "@type.outer", --
                ["it"] = "@type.inner", --
                ["aT"] = "@type.definition.outer", --
                ["iT"] = "@type.definition.inner", --
                ["ac"] = "@class.outer", --
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = {
                  query = "@class.inner", --
                  desc = "Select inner part of a class region", --
                }, --
                ["aC"] = "@constructor.outer", --
                ["iC"] = "@constructor.inner", --
                -- You can also use captures from other query groups like `locals.scm`
                ["a;"] = {
                  query = "@scope",
                  query_group = "locals",
                  desc = "Select language scope",
                }, --
                ["a]"] = "@frame.outer", --
                ["i]"] = "@frame.inner", --
                ["ar"] = "@return.outer", --
                ["ir"] = "@return.inner", --
                ["aA"] = "@assignment.outer", --
                ["iA"] = "@assignment.inner", --
              }, -- }}}
              -- {{{
              -- You can choose the select mode (default is charwise 'v')
              --
              -- Can also be a function which gets passed a table with the keys
              -- * query_string: eg '@function.inner'
              -- * method: eg 'v' or 'o'
              -- and should return the mode ('v', 'V', or '<c-v>') or a table
              -- mapping query_strings to modes.
              -- }}}
              selection_modes = { -- {{{
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
              }, -- }}}
              -- {{{
              -- If you set this to `true` (default is `false`) then any textobject is
              -- extended to include preceding or succeeding whitespace. Succeeding
              -- whitespace has priority in order to act similarly to eg the built-in
              -- `ap`.
              --
              -- Can also be a function which gets passed a table with the keys
              -- * query_string: eg '@function.inner'
              -- * selection_mode: eg 'v'
              -- and should return true or false
              include_surrounding_whitespace = false,
              -- }}}
            }, -- }}}

            move = { -- TODO {{{

              -- {{{
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              -- }}}

              goto_next_start = {
                -- {{{

                ["]m"] = "@function.outer",
                ["]]"] = {
                  query = "@class.outer",
                  desc = "Next class start",
                }, -- }}}
                -- {{{
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["]o"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }

                -- }}}

                -- {{{

                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                ["]s"] = {
                  query = "@scope",
                  query_group = "locals",
                  desc = "Next scope",
                },
                ["]z"] = {
                  query = "@fold",
                  query_group = "folds",
                  desc = "Next fold",
                },

                -- }}}
              },
              goto_next_end = { -- {{{
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              }, -- }}}
              goto_previous_start = { -- {{{
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              }, -- }}}
              goto_previous_end = { -- {{{
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              }, -- }}}
              -- {{{
              -- Below will go to either the start or the end, whichever is closer.
              -- Use if you want more granular movements
              -- Make it even more gradual by adding multiple queries and regex.
              goto_next = { ["]d"] = "@conditional.outer" },
              goto_previous = { ["[d"] = "@conditional.outer" },
              -- }}}
            }, -- }}}
          },

          refactor = { -- {{{
            highlight_definitoins = {
              enable = true,
              -- TODO C
              clear_on_cursor_move = true,
            },

            highlight_current_scope = { enable = true },

            smart_rename = {
              enable = true,
              keymaps = { smart_rename = tskey .. "s" },
            },

            navigation = {
              enable = true,
              keymaps = {
                goto_definition = tskey .. "d",
                list_definitions = tskey .. "l",
                list_definitions_toc = tskey .. "L",
                goto_next_usage = tskey .. "n",
                goto_previous_usage = tskey .. "p",
              },
            },
          }, -- }}}

          matchup = { --  {{{
            enable = true,
            disable_virtual_text = true,
            include_match_words = true,
          }, --  }}}
        }
      )

      -- setting maps {{{
      -- TODO more

      nkeymap(
        "<Leader>dqt", ":<C-u>TSToggle highlight<CR>",
        { noremap = true }
      )

      -- }}}
    end,
  }
)
