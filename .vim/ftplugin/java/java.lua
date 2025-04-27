local nvim_local_dir = vim.fn.expand("~/.local/share/nvim")
local project_name = vim.fn.fnamemodify(
  vim.fn.getcwd(), ":p:h:t"
)

local workspace_dir = nvim_local_dir .. "/jdtls-workspaces/" ..
                        project_name

-- local classpath 

local config = {
  cmd = {
    "jdtls",
    "-data",
    workspace_dir,
    --
  },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {},
        importOrder = { "java", "javax", "com", "org" },
      },

      autobuild = { enabled = false },
      rename = { enabled = true },
      trace = { server = "verbose" },

      import = {
        enabled = true,
        gradle = { enabled = true },
        maven = { enabled = true },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
        },
      },

      format = { enable = true },

      -- configuration = {
      --  runtimes = {
      --    {
      --      name = os.getenv("JAVA_NAME"),
      --      path = os.getenv("JAVA_HOME"),
      --      --
      --    },

    },
  },
  sources = {
    organizeImports = {
      starThreshold = 9999,
      staticStarThreshold = 9999,
    },
  },
  on_attach = lsp_attach,

  handlers = { ["language/status"] = function() end },

  root_dir = vim.fs.dirname(
    vim.fs.find(
      { "gradlew", ".git", "mvnw", ".hg" }, { upward = true }
    )[1]
  ),
}

local success, jdtls = pcall(require, "jdtls")
if success then jdtls.start_or_attach(config) end
