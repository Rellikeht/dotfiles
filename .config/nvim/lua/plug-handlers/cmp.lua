local cmp = require('cmp')
local autopairs = require('nvim-autopairs').setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local snippy = require('snippy')

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
Capabilities = require('cmp_nvim_lsp').default_capabilities()

-- If you want insert `(` after select function or method item
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completeopt = 'menu,menuone,noselect,noinsert',

  enabled = function()
    local context = require('cmp.config.context')
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'c' then
      return true
    else
      return not context.in_syntax_group('Comment') and
               not context.in_syntax_group('String')
    end
  end,

  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-n>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior,
      count = 1
    }),
    ['<C-p>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior,
      count = 1
    }),

    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(8),
    ['<C-b>'] = cmp.mapping.scroll_docs(-8)
  }),

  snippet = {expand = function(args) snippy.expand_snippet(args.body) end},

  sources = {{name = 'nvim_lua'}, {name = 'nvim_lsp'}}
})
