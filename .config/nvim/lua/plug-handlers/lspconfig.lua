local lspconfig = require("lspconfig")

local diag_modes = {"n", "v"}
local buf_modes = {"n", "v"}

vim.keymap.set(buf_modes, "<Leader>dI", ":LspInfo<CR>")
vim.keymap.set(buf_modes, "<Leader>dQ", ":LspLog<CR>")
vim.keymap.set(buf_modes, "<Leader>dL", ":LspRestart<CR>")
vim.keymap.set(buf_modes, "<Leader>dS", ":LspStart<CR>")
vim.keymap.set(buf_modes, "<Leader>de", ":LspStop ")
vim.keymap.set(buf_modes, "<Leader>dE", ":LspStop<CR>")

vim.keymap.set(diag_modes, "<Leader>df",
               vim.diagnostic.open_float)
vim.keymap.set(diag_modes, "<Leader>dp",
               vim.diagnostic.goto_prev)
vim.keymap.set(diag_modes, "<Leader>dn",
               vim.diagnostic.goto_next)
vim.keymap.set(diag_modes, "<Leader>dl",
               vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- :help vim.lsp.*
    local opts = {buffer = ev.buf}

    vim.keymap.set(buf_modes, "<Leader>dd",
                   vim.lsp.buf.declaration, opts)
    vim.keymap.set(buf_modes, "<Leader>dD",
                   vim.lsp.buf.definition, opts)
    vim.keymap.set(buf_modes, "<Leader>dh", vim.lsp.buf.hover,
                   opts)
    vim.keymap.set(buf_modes, "<Leader>di",
                   vim.lsp.buf.implementation, opts)
    vim.keymap.set(buf_modes, "<Leader>ds",
                   vim.lsp.buf.signature_help, opts)

    vim.keymap.set(buf_modes, "<Leader>dt",
                   vim.lsp.buf.type_definition, opts)
    vim.keymap.set(buf_modes, "<Leader>dR", vim.lsp.buf.rename,
                   opts)
    vim.keymap.set(buf_modes, "<Leader>dr",
                   vim.lsp.buf.references, opts)
    vim.keymap.set(buf_modes, "<Leader>dF", function()
      vim.lsp.buf.format({async = true})
    end, opts)

    vim.keymap.set(buf_modes, "<Leader>da",
                   vim.lsp.buf.code_action, opts)
    vim.keymap.set(buf_modes, "<Leader>dwa",
                   vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set(buf_modes, "<Leader>dwr",
                   vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set(buf_modes, "<Leader>dwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.keymap.set("i", "<C-Space>", vim.lsp.buf.completion,
                   opts)
  end
})

local function ssetup(server)
  local config = lspconfig[server]
  if vim.fn.executable(
    config.document_config.default_config.cmd[1]) == 0 then
    return
  end

  config.setup({
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    on_attach = lsp_attach,
    capabilities = Capabilities,
    settings = {telemetry = {enable = false}}
  })
end

local servers = {
  "pylyzer",
  "pylsp",
  "gopls",
  "ocamllsp",
  "nimls",
  -- "julials",
  "nil_ls",
  "nickel_ls",
  "zls",
  "hls",
  "dhall_lsp_server",
  "r_language_server",
  "bashls",
  "texlab",
  "typst_lsp",
  "scheme_langserver",
  "tsserver"
}

for _, s in ipairs(servers) do ssetup(s) end

lspconfig.lua_ls.setup({
  preselectSupport = false,
  preselect = false,
  single_file_support = true,
  on_attach = lsp_attach,
  capabilities = Capabilities,

  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim", "require"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {enable = false}
    }
  }

})

util = require("lspconfig.util")

lspconfig.julials.setup({
  preselectSupport = false,
  preselect = false,
  single_file_support = true,
  on_attach = lsp_attach,
  capabilities = Capabilities,
  settings = {telemetry = {enable = false}},

  cmd = {
    "julia",
    "-g0",
    "-O0",
    "--startup-file=no",
    "--history-file=no",
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
  ]]
  }

})

-- TODO copying rust-project.json from config dir
-- to current dir to make this shit work

-- No idea if all of that is really needed
lspconfig.rust_analyzer.setup({
  on_attach = lsp_attach,
  preselectSupport = false,
  preselect = false,
  single_file_support = true,
  capabilities = Capabilities,

  settings = {
    ["rust-analyzer"] = {
      standalone = true,
      workspaceFolders = false,
      workspace = {workspaceFolders = false},

      completion = {contextSupport = true},
      imports = {
        granularity = {group = "module"},
        prefix = "self"
      },
      cargo = {buildScripts = {enable = true}},
      procMacro = {enable = true}
    }
  }
})

-- lspconfig.pylyzer.setup({
--   cmd = {"pylyzer", "--server"},

--   --   root_dir = function(fname)
--   --     local root_files = {
--   --       "setup.py",
--   --       "tox.ini",
--   --       "requirements.txt",
--   --       "Pipfile",
--   --       "pyproject.toml"
--   --     }
--   --     return util.root_pattern(unpack(root_files))(fname) or
--   --              util.find_git_ancestor(fname)
--   --   end,

--   single_file_support = true,
--   settings = {
--     python = {
--       diagnostics = true,
--       inlayHints = true,
--       smartCompletion = true,
--       checkOnType = true
--     }
--   }
-- })

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "-j=2",
    "--clang-tidy",
    "--enable-config",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--pch-storage=memory"
  },
  preselectSupport = false,
  preselect = false,
  single_file_support = true,
  on_attach = lsp_attach,
  capabilities = Capabilities,
  settings = {}
})

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
