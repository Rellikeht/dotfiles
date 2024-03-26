-- This is all copied, hopefully will work well
-- Java language server is more helpful
local nvim_local_dir = vim.fn.expand("~/.local/share/nvim")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = nvim_local_dir .. "/jdtls-workspaces/" .. project_name

local config = {
  cmd = {'jdtls', '-data', workspace_dir},

  settings = {
    java = {signatureHelp = {enabled = true}, autobuild = {enabled = false}}
  },

  completion = {favoriteStaticMembers = {"java.text.MessageFormat.format"}},
  handlers = {["language/status"] = function() end},

  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'},
                                        {upward = true})[1])
}

require('jdtls').start_or_attach(config)
