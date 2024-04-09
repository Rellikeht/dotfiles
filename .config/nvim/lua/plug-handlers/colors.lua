local tsconfig = require('nvim-treesitter.configs')
tsconfig.setup({
  ensure_installed = {
    "lua", "vim", "vimdoc", "query", "comment", "todotxt", "c", "bash", "ocaml",
    "commonlisp", "go", "gomod", "gowork", "scheme", "nix", "dhall",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "diff", "markdown", "markdown_inline", "html", "css", "json", "latex",
    "ebnf", "ini", "toml", "yaml", "julia", "haskell", "zig", "python",
    "verilog", "elixir", "clojure", "racket", "make", "ninja", "meson", "cmake",
    "sql", "rust", "cpp", "erlang", "cuda", "r", "java", "scala", "ada", "odin",
    "fortran", "perl", "asm"
  },

  -- TODO C org

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  -- auto_install = true,

  -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  incremental_selection = {enable = true},

  indent = {enable = true},

  highlight = {
    enable = true,

    -- ????
    -- use_languagetree = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --   local max_filesize = 100 * 1024 -- 100 KB
    --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --   if ok and stats and stats.size > max_filesize then return true end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false
  }
})

-- vim.cmd('hi Todo		guifg=#ffcf2f	guibg=#0e1224	gui=bold')

-- TODO fucking todo can't change it's color
-- easy to use plugin they say

-- vim.api.nvim_set_hl(0, '@text.todo', { link = 'Todo' })
-- vim.api.nvim_command('hi Todo guifg=#ff0000 guibg=#ff0000 gui=bold')

require'nvim-treesitter.configs'.setup({
  textobjects = {

    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>Df"] = "@function.outer",
        ["<leader>DF"] = "@class.outer"
      }
    },

    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = {
          query = "@class.inner",
          desc = "Select inner part of a class region"
        },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = {
          query = "@scope",
          query_group = "locals",
          desc = "Select language scope"
        }
      },

      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>' -- blockwise
      },

      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = {query = "@class.outer", desc = "Next class start"},
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = {query = "@scope", query_group = "locals", desc = "Next scope"},
        ["]z"] = {query = "@fold", query_group = "folds", desc = "Next fold"}
      },
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"},
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {["]d"] = "@conditional.outer"},
      goto_previous = {["[d"] = "@conditional.outer"}
    }
  }
})
