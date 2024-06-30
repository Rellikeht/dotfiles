---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")

local diag_modes = {"n", "v"}
local buf_modes = {"n", "v"}

vim.keymap.set(
  buf_modes, "<Leader>dqi", ":LspInfo<CR>", {noremap = true}
)
vim.keymap.set(
  buf_modes, "<Leader>dql", ":LspLog<CR>", {noremap = true}
)
vim.keymap.set(
  buf_modes, "<Leader>dqr", ":LspRestart<CR>", {noremap = true}
)
vim.keymap.set(
  buf_modes, "<Leader>dqs", ":LspStart<CR>", {noremap = true}
)
vim.keymap.set(
  buf_modes, "<Leader>dqe", ":LspStop ", {noremap = true}
)
vim.keymap.set(
  buf_modes, "<Leader>dqE", ":LspStop<CR>", {noremap = true}
)

vim.keymap.set(
  diag_modes, "<Leader>df", vim.diagnostic.open_float,
  {noremap = true}
)
vim.keymap.set(
  diag_modes, "<Leader>dp",
  commandRep(vim.diagnostic.goto_prev), {noremap = true}
)
vim.keymap.set(
  diag_modes, "<Leader>dn",
  commandRep(vim.diagnostic.goto_next), {noremap = true}
)

vim.keymap.set(
  diag_modes, "<Leader>dl", vim.diagnostic.setloclist,
  {noremap = true}
)
vim.keymap.set(
  diag_modes, "<Leader>dL", vim.diagnostic.setqflist,
  {noremap = true}
)

-- WTF IS THAT SHIT
-- vim.keymap.set(
--   "i", "<C-g>d", function()
--     vim.cmd.stopinsert()
--     vim.lsp.buf.signature_help()
--     vim.defer_fn(function() vim.cmd.wincmd("w") end, 100)
--     vim.keymap.set("n", "q", ":close<CR>", {buffer = true})
--   end
-- )

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd(
  "LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- :help vim.lsp.*
      local opts = {buffer = ev.buf, noremap = true}
      local tab_mod = "<C-w>"

      vim.keymap.set(
        buf_modes, "<Leader>dd", vim.lsp.buf.definition, opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dd",
        "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dD", vim.lsp.buf.declaration, opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dD",
        "<cmd>tab split | lua vim.lsp.buf.declaration()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>di", vim.lsp.buf.implementation,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>di",
        "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>ds", vim.lsp.buf.signature_help,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>ds",
        "<cmd>tab split | lua vim.lsp.buf.signature_help()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dt", vim.lsp.buf.type_definition,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dt",
        "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dR", vim.lsp.buf.rename, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dr", vim.lsp.buf.references, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dF",
        function() vim.lsp.buf.format({async = true}) end, opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dh", vim.lsp.buf.hover, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>da", vim.lsp.buf.code_action, opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dwa",
        vim.lsp.buf.add_workspace_folder, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dwr",
        vim.lsp.buf.remove_workspace_folder, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dwl", function()
          print(
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          )
        end, opts
      )

      vim.keymap.set(
        -- "i", "<C-Space>", vim.lsp.buf.completion, opts
        "i", "<C-Space>", vim.lsp.omnifunc, opts
      )
    end,
  }
)

local function ssetup(server)
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

local servers = {
  -- "pylyzer",
  "pylsp",
  "gopls",
  "ocamllsp",
  "nimls",
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
  "tsserver",
}

for _, s in ipairs(servers) do ssetup(s) end
local plug_dir = "plug-handlers/"
require(plug_dir .. "servers")
