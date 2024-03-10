local lspconfig = require('lspconfig')

local diag_modes = {'n', 'v'}
local buf_modes = {'n', 'v'}

-- TODO other diagnostics, errors, repairs, info...
vim.keymap.set(diag_modes, '<Leader>df', vim.diagnostic.open_float)
vim.keymap.set(diag_modes, '<Leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set(diag_modes, '<Leader>dn', vim.diagnostic.goto_next)
vim.keymap.set(diag_modes, '<Leader>dl', vim.diagnostic.setloclist)

-- TODO do that all well :(

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = {buffer = ev.buf}

    vim.keymap.set(buf_modes, '<Leader>dI', ':LspInfo<CR>')
    vim.keymap.set(buf_modes, '<Leader>dQ', ':LspLog<CR>')
    vim.keymap.set(buf_modes, '<Leader>dL', ':LspRestart<CR>')
    vim.keymap.set(buf_modes, '<Leader>dS', ':LspStart<CR>')
    vim.keymap.set(buf_modes, '<Leader>dE', ':LspStop<CR>')

    vim.keymap.set(buf_modes, '<Leader>dd', vim.lsp.buf.declaration, opts)
    vim.keymap.set(buf_modes, '<Leader>dD', vim.lsp.buf.definition, opts)
    vim.keymap.set(buf_modes, '<Leader>dh', vim.lsp.buf.hover, opts)
    vim.keymap.set(buf_modes, '<Leader>di', vim.lsp.buf.implementation, opts)
    vim.keymap.set(buf_modes, '<Leader>ds', vim.lsp.buf.signature_help, opts)

    vim.keymap.set(buf_modes, '<Leader>dt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set(buf_modes, '<Leader>dR', vim.lsp.buf.rename, opts)
    vim.keymap.set(buf_modes, '<Leader>dr', vim.lsp.buf.references, opts)
    vim.keymap.set(buf_modes, '<Leader>dF',
                   function() vim.lsp.buf.format {async = true} end, opts)

    vim.keymap.set(buf_modes, '<Leader>da', vim.lsp.buf.code_action, opts)

    --  vim.keymap.set(buf_modes, '<Leader>', vim.lsp.buf.add_workspace_folder, opts)
    --  vim.keymap.set(buf_modes, '<Leader>', vim.lsp.buf.remove_workspace_folder, opts)
    --  vim.keymap.set(buf_modes, '<Leader>', function()
    --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --  end, opts)

    -- FUCK
    vim.keymap.set('i', '<C-Space>', vim.lsp.buf.completion, opts)
  end
})

local function ssetup(server)
  local config = lspconfig[server]
  if vim.fn.executable(config.document_config.default_config.cmd[1]) == 0 then
    return
  end

  config.setup({
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    on_attach = lsp_attach,
    capabilities = Capabilities
    -- settings = {}
  })
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = {
  -- 'pylyzer',
  'pylsp', -- pylyzer is unstable :(
  'gopls', 'clangd', 'ocamllsp', 'nimls',

  -- Am i stupid, or nix language servers do almost nothing
  -- where is my completion
  -- 'nixd',
  'nil_ls', 'julials', 'zls', 'hls', -- 'r_language_server'
  'bashls', 'texlab', 'typst_lsp', 'scheme_langserver', 'tsserver'
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
        globals = {'vim', 'require'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {enable = false}
    }
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
    ['rust-analyzer'] = {
      -- Doesn't solve the problem
      -- standalone = true,
      -- workspaceFolders = false,
      -- workspace = {
      --    workspaceFolders = false,
      -- },

      completion = {contextSupport = true},

      imports = {granularity = {group = 'module'}, prefix = 'self'},

      cargo = {buildScripts = {enable = true}},

      procMacro = {enable = true}

    }
  }
})

-- This has some weird problems
lspconfig.java_language_server.setup({
  cmd = {'java-language-server'},
  preselectSupport = false,
  preselect = false,
  single_file_support = true,
  on_attach = lsp_attach,
  capabilities = Capabilities
  -- settings = {}
})
