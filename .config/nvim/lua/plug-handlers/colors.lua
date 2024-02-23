local tsconfig = require('nvim-treesitter.configs')
tsconfig.setup({
  ensure_installed = {
    "lua", "vim", "vimdoc", "query", "comment", "todotxt", "c", "bash", "ocaml",
    "go", "gomod", "gowork", "scheme", "nix", "git_config", "git_rebase",
    "gitattributes", "gitcommit", "gitignore", "diff", "markdown",
    "markdown_inline", "html", "css", "json", "latex", "ebnf", "ini", "toml",
    "yaml", "julia", "haskell", "zig", "python", "verilog", "elixir", "clojure",
    "racket", "make", "ninja", "meson", "cmake", "sql", "rust", "cpp", "erlang",
    "cuda", "r", "java", "scala", "ada", "odin", "fortran", "perl"
  },

  -- TODO B lisp
  -- TODO C org

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
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
