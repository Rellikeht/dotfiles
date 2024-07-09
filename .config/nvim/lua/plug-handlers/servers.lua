---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup(
  {
    -- {{{ boilerplate
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    on_attach = lsp_attach,
    capabilities = Capabilities,
    -- }}}

    on_init = function(client) -- {{{
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. "/.luarc.json") or
        vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend(
                                     "force", client.config
                                       .settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },

          -- Make the server aware of Neovim runtime files
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
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
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

lspconfig.julials.setup(
  {
    -- {{{ boilerplate
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    on_attach = lsp_attach,
    capabilities = Capabilities,
    settings = {telemetry = {enable = false}},
    -- }}}

    cmd = { -- {{{
      "julia",
      "-g0",
      "-O0",
      "--math-mode=user",
      "--threads",
      "auto",
      "--startup-file=no",
      "--history-file=no",
      "--color=no",
      "--quiet",
      "-e",
      [[
    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
    # with the regular load path as a fallback
    ls_install_path = joinpath(
        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
        "environments", "nvim-lspconfig"
    )
    pushfirst!(LOAD_PATH, ls_install_path)
    using LanguageServer
    popfirst!(LOAD_PATH)
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    project_path = let
        dirname(something(
            ## 1. Finds an explicitly set project (JULIA_PROJECT)
            Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
            )),
            ## 2. Look for a Project.toml file in the current working directory,
            ##    or parent directories, with $HOME as an upper boundary
            Base.current_project(),
            ## 3. First entry in the load path
            get(Base.load_path(), 1, nothing),
            ## 4. Fallback to default global environment,
            ##    this is more or less unreachable
            Base.load_path_expand("@v#.#"),
        ))
    end
    @info "Running language server" VERSION pwd() project_path depot_path
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
  ]],
    }, -- }}}
  }
)

-- TODO copying rust-project.json from config dir
-- to current dir to make this shit work

-- No idea if all of that is really needed
lspconfig.rust_analyzer.setup(
  {
    -- {{{ boilerplate
    on_attach = lsp_attach,
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    capabilities = Capabilities,
    -- }}}

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
        cargo = {buildScripts = {enable = true}},
        procMacro = {enable = true},
      },
    }, -- }}}
  }
)

-- {{{

-- local util = require("lspconfig.util")
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

lspconfig.clangd.setup(
  {
    -- {{{ boilerplate
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    on_attach = lsp_attach,
    capabilities = Capabilities,
    -- }}}

    cmd = { -- {{{
      "clangd",
      "-j=2",
      "--clang-tidy",
      "--enable-config",
      "--header-insertion=never",
      "--completion-style=detailed",
      "--pch-storage=memory",
    }, -- }}}

    settings = { -- {{{
    }, -- }}}
  }
)

-- {{{
--   cmd = {
--     'julia', '--startup-file=no', '--history-file=no', '-e', [[
--       code = :(
--         using LanguageServer;
--         function serv(infile, outfile, path=pwd())
--           cd(path)
--           # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
--           # with the regular load path as a fallback
--           ls_install_path = joinpath(
--               get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
--               "environments", "nvim-lspconfig"
--           );
--           pushfirst!(LOAD_PATH, ls_install_path);
--           popfirst!(LOAD_PATH);
--           depot_path = get(ENV, "JULIA_DEPOT_PATH", "");
--           project_path = let
--               dirname(something(
--                   ## 1. Finds an explicitly set project (JULIA_PROJECT)
--                   Base.load_path_expand((
--                       p = get(ENV, "JULIA_PROJECT", nothing);
--                       p === nothing ? nothing : isempty(p) ? nothing : p
--                   )),
--                   ## 2. Look for a Project.toml file in the current working directory,
--                   ##    or parent directories, with $HOME as an upper boundary
--                   Base.current_project(),
--                   ## 3. First entry in the load path
--                   get(Base.load_path(), 1, nothing),
--                   ## 4. Fallback to default global environment,
--                   ##    this is more or less unreachable
--                   Base.load_path_expand("@v#.#"),
--               ))
--           end;
--           @info "Running language server" VERSION pwd() project_path depot_path;
--           server = LanguageServer.LanguageServerInstance(infile, outfile, project_path, depot_path);
--           server.runlinter = true;

--           open("daemon", "w") do f
--             write(f, infile);
--             write(f, "\n");
--             write(f, outfile);
--           end;
--           run(server);
--         end
--       )

--       LSPORT=3210
--       try
--         import Pkg
--         _ = Pkg.installed()["DaemonMode"]
--         import Sockets
--         import DaemonMode
--         s = Sockets.connect(LSPORT)
--         close(s)

--         # What a lovely workaround
--         f(x, y) = x
--         infile = mktemp(f)
--         outfile = mktemp(f)
--         run(`mkfifo $(infile)`)
--         run(`mkfifo $(outfile)`)
--         DaemonMode.runexpr(string(code),port=LSPORT)
--         DaemonMode.runexpr("
--           open(\"$(infile)\", \"r\") do in
--             open(\"$(outfile)\", \"w\") do out
--               serv(in, out, \"$(pwd())\");
--             end;
--           end;
--         ",port=LSPORT)

--       catch _
--         eval(code)
--         serv(stdin, stdout)
--       end
--   ]]
--   }

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
