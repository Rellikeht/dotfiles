-- helpers {{{
---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")

---@diagnostic disable: unused-local
local util = require("lspconfig.util")

local lazy_utils = require("lazy_utils")

local function default_setup_server(server)
  local config = lspconfig[server]
  if vim.fn.executable(
    config.document_config.default_config.cmd[1]
  ) == 0 then return end
  config.setup(
    {
      preselectSupport = false,
      preselect = false,
      single_file_support = true,
      on_attach = lsp_attach,
      capabilities = Capabilities,
      settings = {telemetry = {enable = false}},
    }
  )
end

local server_augroup_id = 0
local function lazy_setup(filetypes, load_function)
  lazy_utils.load_on_filetypes(
    filetypes, function()
      load_function()
      vim.cmd.LspStart()
    end
  )
end

-- }}}

local servers = { -- {{{
  -- must have
  -- :(
  -- [{"python"}] = "pylyzer",
  [{
    "ocaml",
    "ocamlinterface",
    "menhir",
    "ocamllex",
    "reason",
    "dune",
    "opam",
  }] = "ocamllsp",
  [{"haskell", "cabal"}] = "hls",
  [{"html"}] = "superhtml",
  [{"html"}] = "html",
  [{"css", "scss", "less"}] = "cssls",
  [{"sh", "bash", "zsh"}] = "bashls",

  -- sometimes needed
  [{"zig", "zir"}] = "zls",
  [{"latex", "tex", "plaintex", "bib"}] = "texlab",
  [{
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.jsx",
  }] = "ts_ls",

  -- just in case
  [{"erlang"}] = "erlangls",
  [{"odin"}] = "ols",
  [{"nickel", "ncl"}] = "nickel_ls",
  [{"scala"}] = "metals",
  [{"kotlin"}] = "kotlin_language_server",
  [{"ada"}] = "ada_ls",
  [{"roc"}] = "roc_ls",
  [{"r", "rmd", "quarto"}] = "r_language_server",
  [{"teal"}] = "teal_ls",
  [{"autohotkey"}] = "autohotkey_lsp",
  [{"yaml.ansible"}] = "ansiblels",
  [{"dhall"}] = "dhall_lsp_server",
  [{"star", "bzl", "BUILD.bazel"}] = "starlark_rust",
  [{"gleam"}] = "gleam",
  [{"fortran"}] = "fortls",

  -- test and select
  [{"solidity"}] = "solang",
  [{"solidity"}] = "solc",
  [{"solidity"}] = "solidity_ls",

  [{"scheme.guile"}] = "guile_ls",
  [{"scheme"}] = "scheme_langserver",
}

for ftypes, name in pairs(servers) do
  lazy_setup(ftypes, function() default_setup_server(name) end)
end
-- universal
default_setup_server("ast_grep")

-- }}}

lazy_setup(
  {"lua"}, function()
    lspconfig.lua_ls.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        on_init = function(client) -- {{{
          ---@diagnostic disable: undefined-field
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or
              vim.loop.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend(
            "force", client.config.settings.Lua, {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              }, -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                },

                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              },
            }
          )
        end, -- }}}
        settings = { -- {{{
          Lua = {
            runtime = {
              version = "LuaJIT", -- Setup your lua path
              path = {
                "?.lua",
                "?/init.lua",
                unpack(vim.split(package.path, ";")),
              },
            },
            hint = {enable = true},
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {"vim", "require"},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              -- library = vim.api.nvim_get_runtime_file("", true),
            },
            format = {
              defaultConfig = {
                indent_style = "space",
                indent_size = 2,
              },
            },
            telemetry = {enable = false},
          },
        }, -- }}}
      }
    )
  end
)

lazy_setup(
  {"python"}, function()
    lspconfig.pylsp.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities,
        -- }}}
        settings = { -- {{{
          pylsp = {
            plugins = {
              jedi_completion = {
                --
                fuzzy = true,
                eager = true,
                include_funciton_objects = true,
              },
              pylsp_mypy = {
                enabled = true,
                live_mode = false,
                dmypy = true,
              },
              pylint = {enabled = false, executable = "pylint"},
              pyls_isort = {
                -- import sorting
                enabled = true,
              },
              pycodestyle = {maxLineLength = 78},
              rope_autoimport = {enabled = true, eager = true},
              ruff = {enabled = true},
            },
          },

          flags = {debounce_text_changes = 100},
        }, -- }}}
      }
    )
  end
)

lazy_setup(
  {"nix"}, function()
    lspconfig.nil_ls.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
          ["nil"] = {
            formatting = {command = {"alejandra"}},
            diagnostics = {
              ignored = {
                -- "unused_rec",
                -- "empty_let_in",
                -- "unused_with",
              },
            },
            nix = {
              maxMemoryMB = 4096,
              flake = {
                --
                autoArchive = false,
                autoEvalInputs = false,
              },
            },
          },
        }, -- }}}
      }
    )
  end
)

lazy_setup(
  {"nim"}, function()
    lspconfig.nim_langserver.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
          nim = {
            notificationVerbosity = "error",
            nimsuggestIdleTimeout = 9999999999,
            autoRestart = true,
            logNimsuggest = false,
          },
        }, -- }}}
      }
    )
  end
)

-- fucking almost useless shit
-- that crashes on every fucking input
lazy_setup(
  {"typst"}, function()
    lspconfig.tinymist.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities,
        offset_encoding = "utf-8",
        -- }}}
        settings = { -- {{{
          offset_encoding = "utf-8",
          semanticTokens = "disable",
          exportPdf = "never",
        }, -- }}}
      }
    )
  end
)

lazy_setup(
  {"go", "gomod", "gowork", "gotmpl"}, function()
    lspconfig.gopls.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
          gopls = {
            completionBudget = "0",
            usePlaceholders = true,
            experimentalPostfixCompletions = true,
            analyses = {unusedparams = true, shadow = true},
            staticcheck = true,
            vulncheck = "Imports",
          },
        }, -- }}}
      }
    )
  end
)

lazy_setup(
  {"julia"}, function()
    lspconfig.julials.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities,
        settings = {telemetry = {enable = false}}, -- }}}
        cmd = { -- {{{
          "julials",
        }, -- }}}
      }
    )
  end
)

-- TODO copying rust-project.json from config dir
-- to current dir to make this shit work

-- No idea if all of that is really needed
lazy_setup(
  {"rust"}, function()
    lspconfig.rust_analyzer.setup(
      {
        -- boilerplate {{{
        on_attach = lsp_attach,
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
          ["rust-analyzer"] = {
            standalone = true,
            workspaceFolders = false,
            workspace = {workspaceFolders = false},

            completion = {contextSupport = true},
            imports = {
              granularity = {group = "module"},
              prefix = "self",
            },
            cargo = {
              buildScripts = {enable = true},
              allFeatures = true,
            },
            procMacro = {enable = true},
          },
        }, -- }}}
      }
    )
  end
)

-- {{{

-- lspconfig.pylyzer.setup(
--   {
--     cmd = {"pylyzer", "--server"},

--     --   root_dir = function(fname)
--     --     local root_files = {
--     --       "setup.py",
--     --       "tox.ini",
--     --       "requirements.txt",
--     --       "Pipfile",
--     --       "pyproject.toml"
--     --     }
--     --     return util.root_pattern(unpack(root_files))(fname) or
--     --              util.find_git_ancestor(fname)
--     --   end,

--     single_file_support = true,
--     settings = {
--       python = {
--         diagnostics = true,
--         inlayHints = true,
--         smartCompletion = true,
--         checkOnType = true,
--       },
--     },
--   }
-- )

-- }}}

lazy_setup(
  {"c", "cpp", "objc", "objcpp", "cuda"}, function()
    lspconfig.clangd.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        cmd = { -- {{{
          "clangd",
          "--clang-tidy",
          "--enable-config",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--pch-storage=memory",
          "--background-index",
          "--background-index-priority=low",
        }, -- }}}
        filetypes = { --  {{{
          "c",
          "cpp",
          "objc",
          "objcpp",
          "cuda",
        }, --  }}}
        settings = { -- {{{
        }, -- }}}
      }
    )

    require("clangd_extensions").setup(
      {
        inlay_hints = { -- {{{
          -- Options other than `highlight' and `priority' only work
          -- if `inline' is disabled
          inline = vim.fn.has("nvim-0.10") == 1,

          -- Only show inlay hints for the current line
          only_current_line = false,

          -- Event which triggers a refresh of the inlay hints.
          -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
          -- note that this may cause higher CPU usage.
          -- This option is only respected when only_current_line is true.
          only_current_line_autocmd = {"CursorHold"},

          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,

          -- prefix for parameter hints
          parameter_hints_prefix = "<- ",

          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",

          -- whether to align to the length of the longest line in the file
          max_len_align = false,

          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,

          -- whether to align to the extreme right or not
          right_align = false,

          -- padding from the right if right_align is true
          right_align_padding = 7, -- The color of the hints
          highlight = "Comment",

          -- The highlight group priority for extmark
          priority = 100,
        }, -- }}}
        ast = { -- {{{
          -- These are unicode, should be available in any font
          role_icons = { -- {{{
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
          }, -- }}}
          kind_icons = { -- {{{
            Compound = "🄲",
            Recovery = "🅁",
            TranslationUnit = "🅄",
            PackExpansion = "🄿",
            TemplateTypeParm = "🅃",
            TemplateTemplateParm = "🅃",
            TemplateParamObject = "🅃",
          }, -- }}}
          highlights = {detail = "Comment"},
        }, -- }}}
        -- {{{
        memory_usage = {border = "none"},
        symbol_info = {border = "none"},
        -- }}}
      }
    )
  end
)

lazy_setup(
  {"elixir"}, function()
    lspconfig.elixirls.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
          fetchDeps = false,
          suggestSpecs = true,
          dialyzerEnabled = true,
          incrementalDialyzer = true,
          enableTestLenses = true,
          mixEnv = true,
        },
        cmd = {"elixir-ls"},
        -- }}}
      }
    )
  end
)

lazy_setup(
  {"ps1"}, function()
    lspconfig.powershell_es.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities, -- }}}
        settings = { -- {{{
        },

        bundle_path = "~/.powershell_es",
        -- }}}
      }
    )
  end
)

lazy_setup(
  {"arduino"}, function()
    lspconfig.arduino_language_server.setup(
      {
        -- boilerplate {{{
        preselectSupport = false,
        preselect = false,
        single_file_support = true,
        on_attach = lsp_attach,
        capabilities = Capabilities,
        -- }}}
        cmd = { --  {{{
          "arduino-language-server",
          -- "-log",
          "-jobs",
          "0",
          -- gives nothing
          -- "-skip-libraries-discovery-on-rebuild",
        }, --  }}}
        settings = { -- {{{
        },

        -- disabledFeatures = { "semanticTokens" },
        autostart = true,
        -- }}}
      }
    )
  end
)

-- {{{

-- This has some weird problems
-- lspconfig.java_language_server.setup({
--   cmd = {'java-language-server'},
--   preselectSupport = false,
--   preselect = false,
--   single_file_support = true,
--   on_attach = lsp_attach,
--   capabilities = Capabilities,
--   -- settings = {}
-- })

-- }}}
